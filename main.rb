require 'sinatra'
configure { set :server, :puma }
# Simple sinatra server
class Main < Sinatra::Base
  set :bind, "0.0.0.0"

  get '/' do
    'Hello world!'
  end
end
