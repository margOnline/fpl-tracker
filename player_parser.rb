class PlayerParser
  attr_accessor :player, :teams

  def self.parse(player)
    new(player).parse
  end

  def initialize(player)
    @player = player
    @teams ||= FplTracker::DB[:teams].as_hash(:id, :name)
  end

  def parse
    Player.new(
      [
        player["first_name"],
        player["second_name"],
        player["photo"],
        get_team_name(player["team"]),
        Player::POSITIONS[player["element_type"]],
        player["now_cost"],
        player["status"],
        player["dreamteam_count"],
        player["in_dreamteam"]
      ]
    )
  end

  private

  def get_team_name(id)
    teams[id]
  end
end
