# Loader
require './loader'
require './adapter_redis'
require 'rufus-scheduler'

adapter = Adapter.new
adapter.clear_pages

s = Rufus::Scheduler.new
x = "#{ENV['TEST_INTER']}s"
x = '60s' if x == 's'
s.every x, first: :now do
 Loader.load_pages("http://arquiapi.ing.puc.cl/news")
end

puts "Starting scheduler every #{x}"
s.join
