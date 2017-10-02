require 'csv'
require 'open-uri'

module CsvAnalysis
  def self.scrape(url)
    File.open("./data.csv", "wb") do |saved_file|
      open(url, "rb") do |read_file|
        saved_file.write(read_file.read)
      end
    end
  end

  def self.format_for_database
    players = []
    CSV.foreach("./data.csv", headers: true) do |row|
      players << {
        position: row[0],
        name: row[1],
        salary: row[2],
        matchup: row[3],
        ppg: row[4],
        team: row[5]
      }
    end
    players
  end
end
