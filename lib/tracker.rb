require 'httparty'
require 'sequel'
require './lib/parsers/response_parser'
require './lib/models/message'
require './lib/notification'

class Tracker
  URL = 'https://fantasy.premierleague.com/drf/bootstrap-static'.freeze
  DB = Sequel.connect('sqlite://dfs.db')
  
  def self.run
    response = HTTParty.get(URI(URL))
    data = ResponseParser.parse(response)
    message = Message.format(data)
    Notification.mms(message)
  end
end

Tracker.run
