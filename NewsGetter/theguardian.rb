require 'nokogiri'
require 'open-uri'
require 'date'
require 'time'
require './utilities'


class TheGuardian
    def fetch_news(last_fetch = "#{Date.today.to_s} 00:00:00")
      news = Array.new
      year  = Date.today.strftime("%Y")
      month = Date.today.strftime("%m")
      day = Date.today.strftime("%d")

      doc = Nokogiri::HTML(open("http://www.theguardian.com/uk/rss"))

      news = doc.xpath("//item").collect do |node|
        time = node.xpath("date/text()")
        title = node.xpath("title/text()")
        header = node.xpath("description/text()")
        url = node.xpath("guid/text()")

        #doc2 = Nokogiri::HTML(open(url.to_s))
        #body = doc2.xpath("//div[contains(@class, 'content__article-body')]").first

        time2 = parseTime time.to_s
        break if !earlier?(last_fetch, time2)
        header2 = parseGuardianHeader header.to_s

        noticia = {title: "#{title}", time: "#{time2}", header: "#{header2}", url: "#{url}", body: ""}
      end
      news
    end
end
