# File for Adapter
require "redis"

# Simple adapter for redis
class Adapter
  attr_accessor :redis

  # initialize the class and the conection
  def initialize
    @redis = Redis.new(host: 'redis', port: 6379)
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
    @redis.set(source, update)
  rescue
    puts "Could not update data. Did you insert the source (new_source)"
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

  def clear_pages
    begin
      @redis.set("ID_FETCHED", nil)
      @redis.set("FETCHED", nil)
      @redis.set("PAGE", 0)
    rescue
    end
  end

  def get_last_fetched
    begin
      res = {id: @redis.get("ID_FETCHED"), page: @redis.get("PAGE"), value: @redis.get("FETCHED")}
      res ||= {id: "", page: "", value: ""}
    rescue
    end
    res
  end

  def update_last_id(value)
    begin
      @redis.set("ID_FETCHED", value)
    rescue
    end
  end

  def update_last_page(value)
    begin
      @redis.set("PAGE", value)
    rescue
    end
  end

  def update_last_value(value)
    begin
      @redis.set("FETCHED", value)
    rescue
    end
  end

end
