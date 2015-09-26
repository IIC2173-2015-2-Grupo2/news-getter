require 'sinatra'
configure { set :server, :puma }

class Main < Sinatra::Base
  get '/' do
    'Hello world!'
  end
end
