require 'nokogiri'
require 'open-uri'
require 'date'
require 'time'
require './source_lib/utilities'


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
      header = node.xpath("description/text()").text
      url = node.xpath("guid/text()")

      time = parseTime time.to_s
      break if !earlier?(last_fetch, time)

      doc2 = Nokogiri::HTML(open(url.to_s))
      body = fetch_body doc2
      tags = fetch_tags doc2

      noticia = {title: "#{title}", time: "#{time}", header: "#{header}", url: "#{url}", body: "#{body}", tags: "#{tags}" }

      noticia
    end
    news
  end

  def fetch_body(body)
    aux = ""
    body.xpath("//div[contains(@class, 'article-center-text')]/p/text()").each do |b|
      aux = aux + b.text + "\n"
    end
    return aux
  end

  def fetch_tags(body)
    aux = []
    body.xpath("//ul[contains(@class, 'listags')]/li/a/text()").each do |f|
      aux << f.text
    end
    return aux
  end
end