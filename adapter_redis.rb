# File for Adapter
require "redis"

# Simple adapter for redis
class Adapter

  attr_accessor :redis

# initialize the class and the conection
  def initialize
    @redis = Redis.new(:host => 'localhost', :port => 6379)
  end

  # erase the info
  def create_db
  ["CNN", "Emol", "LaCuarta", "LaTercera", "SoyChile"].each do |source|
    @redis.set(source, "2000-01-01 00:00:00")
  end

  Dir["./source_lib/*.json"].each do |source|
    @redis.set(source, "2000-01-01 00:00:00")
  end
  @redis.set("SOURCES",Dir["./source_lib/*.json"].count)
end



# get last fetch
  def last_fetch source
    begin
      res = @redis.get(source)
      res ||= "2000-01-01 00:00:00"
    rescue
    end
    res
  end

  # get source count
  def source_count
    begin
      return @redis.get("SOURCES")
    rescue
    end
  end


# update last_fetch
  def update_last_fetch(source, update)
    begin
      @redis.set(source, update)
    rescue
      puts "Could not update data. Did you insert the source (new_source)"
    end
  end

# add a new source to the database
  def new_source(source)
    begin
      @redis.set(source, "2000-01-01 00:00:00")
      a = @redis.get("SOURCES")
      a = a +1
      @redis.set("SOURCES", a)
    rescue
    end
  end

end
