require 'sequel'
require 'httparty'
require './tracker'
require './player'

class SetupPlayers
  def self.create_table(db_conn)
    unless db_conn.table_exists?(:players)
      db_conn.create_table :players do
        primary_key :id
        String :first_name
        String :last_name
        String :photo
        String :team_id
        String :position
        String :status
        Float :cost
        Integer :dreamteam_count
        Boolean :in_dreamteam
      end
    end
    populate(db_conn)
  end

  def self.populate(db_conn)
    url = Tracker::URL
    player_data = HTTParty.get(URI(url)).parsed_response['elements']
    players_table = db_conn[:players]
    players = []

    player_data.each do |player|
      players << {
        first_name: player['first_name'],
        last_name: player['second_name'],
        photo: player['photo'],
        team_id: player['team'],
        position: Player::POSITIONS[player['element_type']],
        cost: player['now_cost'],
        status: player['status'],
        dreamteam_count: player['dreamteam_count'],
        in_dreamteam: player['in_dreamteam']
      }
    end
    
    players.each{ |player| players_table.insert(player) }
  end
end


