require "sqlite3"

# adapter for db
class Adapter
  attr_accessor :db

  def initialize
    @db = SQLite3::Database.new "source.db"
  end

  def create_db
    # Create a database
    @db.execute <<-SQL
    create table sources (
      source varchar(30),
      last_fetch varchar(30)
        );
    SQL

    {
    "CNN" => "2000-01-01 00:00:00",
    "./source_lib/emol.json" => "2000-01-01 00:00:00",
    "LaCuarta" => "2000-01-01 00:00:00",
    "./source_lib/latercera.json" => "2000-01-01 00:00:00",
    "SoyChile" => "2000-01-01 00:00:00"
    }.each do |pair|
    @db.execute "insert into sources values ( ?, ? )", pair
    end
  end

  def last_fetch source
    begin
      @db.execute( "select (last_fetch) from sources where source = '#{source}'" ) do |row|
        return row.first
      end
    rescue
      puts "Could not fetch data. Did you create the database (create_db)"
    end
  end

  def update_last_fetch(source, update)
    begin
      @db.execute("update sources set last_fetch = '#{update}' where source = '#{source}'")
    rescue
      puts "Could not update data. Did you insert the source (new_source)"
    end
  end

  def new_source(source)
    begin
      @db.execute("insert into sources values ('#{source}', '2000-01-01 00:00:00')")
    rescue
      puts "Could not create source. Did you create the database (create_db)"
    end
  end
end
