require 'sqlite3'

DB = {:conn => SQLite3::Database.new("./Chinook_Sqlite.db")}

DB[:conn].results_as_hash = true
