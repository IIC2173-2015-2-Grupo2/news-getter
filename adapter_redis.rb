# File for Adapter
require "redis"

# Simple adapter for redis
class Adapter

  attr_accessor :redis

# initialize the class and the conection
  def initialize
    @redis = Redis.new(:host => ENV["REDIS_HOST"], :port => ENV["REDIS_PORT"], :db =>ENV["REDIS_DB"])
  end

# create databse with some info
  def create_db
    ["CNN", "Emol", "LaCuarta", "LaTercera", "SoyChile"].each do |source|
      @redis.set(source, "2000-01-01 00:00:00")
    end
  end

# get last fetch
  def last_fetch source
    begin
      return @redis.get(source)
    rescue
      "Could not fetch data. Did you create the database (create_db)"
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
    rescue
      puts "Could not create source. Did you create the database (create_db)"
    end
  end

end
