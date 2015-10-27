# simple script to start everything
system "ruby config_db.rb"

# simple server
require 'sinatra'

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


# start scheduler in the background
system "ruby scheduler.rb &"
