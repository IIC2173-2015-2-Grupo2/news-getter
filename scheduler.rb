# Scheduler file
require 'rufus-scheduler'
require './loader'

class Scheduler
  def initialize
    s = Rufus::Scheduler.new
    puts "Starting Scheduler"
    # simple scheduling  of the loader
    s.every '780s', :first => :now do
      Dir["./source_lib/*.json"].each do |source|
        Loader.load(source)
        sleep(60)
      end
    end
    s.every '60s', :first => :now do
  	 Loader.load_pages("http://arquiapi.ing.puc.cl/news")
    end
  end
end
