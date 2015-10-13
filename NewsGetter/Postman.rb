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
		@@news << noticia
	end

	def done_fetch
		if !@@news.nil?
			puts "Enviando noticias..."
			last_news = {
				body: {
					news: @@news
				}
			}
		    Postman.send_news('/', last_news)
		    puts "Noticias enviadas."
		end
	end


	private

	def self.send_news(uri, object)
		post(uri, object)
	end
end
