require 'httparty'
require 'sequel'
require './response_parser'
require './message'
require './notification'

class FplTracker
  URL = 'https://fantasy.premierleague.com/drf/bootstrap-static'.freeze
  DB = Sequel.connect('sqlite://dfs.db')
  
  def self.run
    response = HTTParty.get(URI(URL))
    data = ResponseParser.parse(response)
    message = Message.format(data)
    Notification.mms(message)
  end
end

FplTracker.run
