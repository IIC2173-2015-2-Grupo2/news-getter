require 'rubygems'
require 'httparty'

class Postman
  include HTTParty
  base_uri 'http://localhost:4567'

  def self.send(uri, object)
    response = post(uri, object)
    puts response
  end
end
