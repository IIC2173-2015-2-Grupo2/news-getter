require 'nokogiri'
require 'open-uri'
require 'date'
require 'time'
require './utilities'


class TheGuardian
    def self.fetch_news(last_fetch = "#{Date.today.to_s} 00:00:00")
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

        time1 = time.to_s
        time2 = parseGuardianTime time1
        #time2 = to_time(year, month, day, time.to_s)
        break if !earlier?(last_fetch, time2)
        header = parseGuardianHeader header.to_s

        noticia = {title: "#{title}", time: "#{time2}", header: "#{header}", url: "#{url}" }
        puts noticia

        noticia
      end
      news
    end
end
