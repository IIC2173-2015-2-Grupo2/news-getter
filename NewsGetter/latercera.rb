require 'nokogiri'
require 'open-uri'
require 'date'
require 'time'
require './utilities'


class LaTercera
    def fetch_news(last_fetch = "#{Date.today.to_s} 00:00:00")
      news = Array.new
      year  = Date.today.strftime("%Y")
      month = Date.today.strftime("%m")
      day = Date.today.strftime("%d")

      doc = Nokogiri::HTML(open("http://www.tercera.cl/feed/manager?type=rss&sc=TEFURVJDRVJB"))

      news = doc.xpath("//item").collect do |node|
        time = node.xpath("pubdate/text()")
        title = node.xpath("title/text()")
        header = node.xpath("description/text()")
        url = node.xpath("guid/text()")

        doc2 = Nokogiri::HTML(open(url.to_s))
        body = doc2.xpath("//div[contains(@class, 'article-center-text')]").first
        
        time = parseTime time.to_s
        break if !earlier?(last_fetch, time)
        header = parseHeader header.to_s
        body = parseBody body.to_s

        noticia = {title: "#{title}", time: "#{time}", header: "#{header}", url: "#{url}", body: "#{body}" }

        noticia
      end
      news
    end
end