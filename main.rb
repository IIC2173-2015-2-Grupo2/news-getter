# simple script to start everything
system "ruby config_db.rb"

# simple server
require 'sinatra'
require './adapter_redis'

set :port, 9494
set :bind, '0.0.0.0'

get '/hi' do
  "Hi there"
end

get '/how-are-you' do
  "Im ok I guess... whatever"
end

get '/log' do
  send_file "cron_log.log"
end

post '/new-source' do
  a = Adapter.new
  File.write("#{Dir.pwd}/source_lib/source#{a.source_count}.json", params.to_s)
  a.new_source("#{Dir.pwd}/source_lib/source#{a.source_count}.json")
  "New Source On lib"
end

# start scheduler in the background
system "ruby scheduler.rb &"
