require 'sinatra'

post '/' do
  puts "#{params.inspect}"
  "Alright Alright Alright #{params.inspect}"
end
