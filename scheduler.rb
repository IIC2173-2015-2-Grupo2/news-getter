# Scheduler file
require 'rufus-scheduler'
require './loader'
require './adapter_redis'

class Scheduler
  def initialize
    adapter = Adapter.new
    adapter.clear_pages
    adapter.create_db
    s = Rufus::Scheduler.new
    puts "Starting Scheduler"
    # simple scheduling  of the loader
    s.every '780s', :first => :now do
      Dir["./source_lib/*.json"].each do |source|
        puts "Loading #{source}"
        Loader.load(source)
        sleep(60)
      end
    end
    s.every '60s', :first => :now do
  	 Loader.load_pages("http://arquiapi.ing.puc.cl/news")
    end
  end
end
