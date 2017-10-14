require './lib/models/player'

class Message
  attr_accessor :data

  def self.format(data)
    new(data).format
  end

  def initialize(data)
    @data = data
  end

  def format
    [title.upcase, body, footer].flatten
  end

  private

  def title
    "Week #{data[:current_event]} Dream team" 
  end

  def body
    data[:dreamteam].sort_by{ |player| player.position_id }.map{ |player| player_message(player) }
  end

  def player_message(player)
    "#{player.fullname}, #{player.position} for #{player.team_name}, costs #{player.formatted_price}"
  end

  def deadline
    data[:next_event]['deadline_time_formatted']
  end

  def footer
    footer_text = "Transfer deadline for next event:"
    [footer_text.upcase, deadline.upcase]
  end
end
