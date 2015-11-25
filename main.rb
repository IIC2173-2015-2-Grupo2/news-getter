# simple script to start everything

# simple server
require 'sinatra'
require './mobile_code'
require './scheduler'
require './adapter_redis'

set :port, 9494
set :bind, '0.0.0.0'
set :environment, :production

class Main < Sinatra::Base
  _ = Scheduler.new
  a = Adapter.new
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
    MobileCode.add_source(param["file"]) if params["key"] = ENV["MOBILE_KEY"]
    "New Source On lib"
  end

end
