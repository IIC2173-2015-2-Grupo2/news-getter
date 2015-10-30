# Scheduler file
require 'rufus-scheduler'
require './loader'

s = Rufus::Scheduler.new

# simple scheduling  of the loader

s.every '780s', :first_in => 1 do
  Dir["./source_lib/*.json"].each do |source|
    Loader.load(source)
    sleep(10)
  end
end

s.join
