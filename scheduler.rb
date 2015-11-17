# Scheduler file
require 'rufus-scheduler'
require './loader'

s = Rufus::Scheduler.new

# simple scheduling  of the loader
s.every '780s', :first_in => 1 do
  Dir["./source_lib/*.json"].each do |source|
    Loader.load(source)
    sleep(60)
  end
end

s.every '60s', :first_in => 1 do
	Loader.load_pages("http://arquiapi.ing.puc.cl/news")
end

s.join
