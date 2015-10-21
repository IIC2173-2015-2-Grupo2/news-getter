require 'nokogiri'
require 'open-uri'
require 'date'
require 'time'
require './source_lib/utilities'

# CNN news getter
class CNN
  def fetch_news(last_fetch = "#{Date.today.to_s} 00:00:00")
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

			time = parseTime time.to_s
			break if !earlier?(last_fetch, time)
			header = parseHeader header.to_s
			body = parseBody body.to_s

			noticia = {title: "#{title}", time: "#{time}", header: "#{header}", url: "#{url}", body: "#{body}" }

			noticia
    end
		news
  end

	def name
		"CNN"
	end
end
