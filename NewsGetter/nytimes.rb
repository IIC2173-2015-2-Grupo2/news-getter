require 'nokogiri'
require 'open-uri'
require 'date'
require 'time'
require './utilities'


class NYTimes
    def fetch_news(last_fetch = "#{Date.today.to_s} 00:00:00")
      news = Array.new
      year  = Date.today.strftime("%Y")
      month = Date.today.strftime("%m")
      day = Date.today.strftime("%d")

      doc = Nokogiri::HTML(open("http://rss.nytimes.com/services/xml/rss/nyt/InternationalHome.xml"))

      news = doc.xpath("//item").collect do |node|
        time = node.xpath("pubdate/text()")
        title = node.xpath("title/text()")
        header = node.xpath("description/text()")
        url = node.xpath("guid/text()")

        #doc2 = Nokogiri::HTML(open(url.to_s))
        body = ''

        #doc2.xpath("//p[contains(@class, 'story-content')]").collect do |node2|
        #  body = body + node2.xpath("/text()")
        #end
        

        time = parseTime time.to_s
        break if !earlier?(last_fetch, time)
        header = parseHeader header.to_s

        noticia = {title: "#{title}", time: "#{time}", header: "#{header}", url: "#{url}", body: "#{body}" }

        noticia
      end
      news
    end
end
