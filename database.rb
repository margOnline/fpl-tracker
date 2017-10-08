require 'sequel'

class Database
  DB = Sequel.connect('sqlite://dfs.db')

  def self.setup
    SetupTeams.create_table(DB)
    SetupPlayers.create_table(DB)
  end
end
