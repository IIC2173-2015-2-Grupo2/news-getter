require 'rubygems'
require 'httparty'
require 'json'

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

 # add the news to a queue
	def add_news noticia
		noticia.each do |n|
			@@news << n
		end
	end

 # check if there is something to send. if there is send it
	def done_fetch
		if !@@news.nil?
			puts "Enviando noticias..."
			options = {
				header: {'Content-type' => 'application/json'},
				body: @@news.to_json
			}
			File.open('file_json_complete.json', 'w') do |f|
  			f.puts @@news.to_json
			end
			begin
		    Postman.send_news(@url, options)
		    puts "Noticias enviadas."
			rescue
				return false
			end
				true
		end
	end

# sendinf function require by httparty
	def self.send_news(uri, object)
		post(uri, object)
	end
end
