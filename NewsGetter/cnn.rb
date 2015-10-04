require 'nokogiri'
require 'open-uri'
require 'date'
require 'time'
require './utilities'


class CNN
	def fetch_news(last_fetch = "#{Date.today.to_s} 00:00:00")
		news = Array.new
		year  = Date.today.strftime("%Y")
		month = Date.today.strftime("%m")
		day = Date.today.strftime("%d")

		doc = Nokogiri::HTML(open("http://rss.cnn.com/rss/edition.rss"))
		
		news = doc.xpath("//item").collect do |node|
			time = node.xpath("pubdate/text()")
			title = node.xpath('title/text()')
			header = node.xpath("description/text()")
			url = node.xpath("guid/text()")

			doc2 = Nokogiri::HTML(open(url.to_s))
			body = ''

        	body = body + doc2.xpath("//div[contains(@class, 'l-container')]/div[contains(@class, 'el__leafmedia--sourced-paragraph')]").first.to_s
        	doc2.xpath("//div[contains(@class, 'l-container')]/p[contains(@class, 'zn-body__paragraph')]").each do |parragraph|
        		body = body + parragraph.to_s
        	end

			time2 = parseTime time.to_s
			body2 = parseBody body.to_s
			break if !earlier?(last_fetch, time2)
			header2 = parseCNNHeader header.to_s

			noticia = {title: "#{title}", time: "#{time2}", header: "#{header2}", url: "#{url}", body: "#{body}" }

			noticia
		end
		news
	end
end