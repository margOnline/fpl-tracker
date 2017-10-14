require 'sequel'
require 'httparty'
require './tracker'

class SetupTeams

  def self.create_table(db_conn)
    unless db_conn.table_exists?(:teams)
      db_conn.create_table :teams do
        primary_key :id
        String :name
        String :tla
      end
    end
    populate(db_conn)
  end

  def self.populate(db_conn)
    url = Tracker::URL
    team_data = HTTParty.get(URI(url)).parsed_response['teams']
    teams_table = db_conn[:teams]
    teams = []

    team_data.each do |team|
      teams << {
        name: team['name'],
        tla: team['short_name']
      }
    end
    
    teams.each do |team|
      teams_table.insert(team)
    end
  end
end
