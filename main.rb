# simple script to start everything
system "ruby config_db.rb"

# simple server
require 'sinatra'

set :port, 9494
set :bind, '0.0.0.0'

get '/hi' do
  "Hello World!"
end

# start scheduler in the background
system "ruby scheduler.rb &"
