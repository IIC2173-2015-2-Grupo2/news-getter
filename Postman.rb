require 'rubygems'
require 'httparty'

class Postman
	include HTTParty
	base_uri 'http://localhost:4567'

	attr_accessor :news

	def initialize
		@@news = []
	end

	def add_news noticia
		noticia.each do |n|
			@@news << n
		end
	end

	def done_fetch
		if !@@news.nil?
			puts "Enviando noticias..."
			options = {
				body: {
					news: @@news
				}
			}
			begin
		    Postman.send_news('/', options)
		    puts "Noticias enviadas."
			rescue
				return false
			end
				true
		end
	end


	def self.send_news(uri, object)
		post(uri, object)
	end
end
