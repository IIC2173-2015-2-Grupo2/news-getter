require 'nokogiri'
require 'open-uri'
require 'date'
require 'time'
require './source_lib/utilities'

# La cuarta news getter
class LaCuarta
  def fetch_news(last_fetch = "#{Date.today.to_s} 00:00:00")
    doc = Nokogiri::HTML(open("http://www.lacuarta.com/feed/manager?type=rss&sc=TEFDVUFSVEE="))

    news = doc.xpath("//item").collect do |node|
      time = node.xpath("pubdate/text()")
      title = node.xpath("title/text()")
      header = node.xpath("description/text()").text
      url = node.xpath("guid/text()")
      tags = ""

      time = parseTime time.to_s
      break if !earlier?(last_fetch, time)

      doc2 = Nokogiri::HTML(open(url.to_s))
      body = fetch_body doc2

      news_builder(title, time, header, url, body, tags)
    end
    news
  end

  def fetch_body(body)
    aux = ""
    body.xpath("//div[contains(@class, 'l4ta_contenedorTxtARtc')]/p/text()").each do |b|
      aux = aux + b.text + "\n"
    end
    return aux
  end

  def name
    "LaCuarta"
  end
end
