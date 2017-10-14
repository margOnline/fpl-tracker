require './lib/parsers/player_parser'

class ResponseParser
  attr_accessor :response

  def self.parse(response)
    new(response).parse
  end

  def initialize(response)
    @response = response
  end

  def parse
    {
      current_event: current_event,
      dreamteam: parse_elements,
      next_event: next_event
    }
  end

  private

  def current_event
    response.parsed_response['current-event']
  end

  def parse_elements
    dreamteam = response.parsed_response['elements'].select do |player|
      player["in_dreamteam"] 
    end

    dreamteam.map{ |player| PlayerParser.parse(player) }
  end

  def next_event
    response.parsed_response['events'].select{ |event| event['is_next'] }.first
  end
end
