URL = './DKSalaries.csv'
require './csv_analysis'
require './database'
require './notification'

module Tracker
  def self.run
    Database.setup
    CsvAnalysis.scrape(URL)
    players_table = DB[:players]
    price_changes = []

    CsvAnalysis.format_for_database.each do |player|
      existing_player = DB[:players].where(name: player[:name], team: player[:team]).first
      if existing_player
        next unless existing_player[:salary] != player[:salary].to_i
        price_changes << existing_player
        DB[:players].where(id: existing_player[:id]).update(salary: player[:salary])
      else
        players_table.insert(player)
      end
    end
    puts price_changes.inspect
    Notification.mms(price_changes) unless price_changes.empty?
  end
end

Tracker.run
