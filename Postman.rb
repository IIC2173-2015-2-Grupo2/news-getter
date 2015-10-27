require 'rubygems'
require 'httparty'

# this class send (posts) the news to the analyzer
class Postman
	include HTTParty
	base_uri "http://#{ENV['URI_ANALYZER']}"

	attr_accessor :news
	attr_accessor :url
	def initialize
		@url = ENV["URL_ANALYZER"]
		@url = "/" if @url == ""
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
