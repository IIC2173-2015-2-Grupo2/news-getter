require 'nokogiri'
require 'open-uri'
require 'date'
require 'time'
require './source_lib/utilities'

# SoyChile news getter
class SoyChile
  def fetch_news(last_fetch = "#{Date.today.to_s} 00:00:00")
    doc = Nokogiri::HTML(open("http://feeds.feedburner.com/Soychilecl-todas?format=xml"))

    doc.xpath("//item").each do |node|
      title = node.xpath("title/text()")
      time = node.xpath("pubdate/text()")
      header = fetch_header node.to_s
      url = fetch_url node.to_s

      time = parseTime time.to_s
      break if !earlier?(last_fetch, time)

      body = fetch_body node.to_s
      tags = ""

      noticia = {title: "#{title}", time: "#{time}", header: "#{header}", url: "#{url}", body: "#{body}", tags: "#{tags}" }

      news << noticia
    end
    news
  end

  def fetch_url(body)
    aux = body.split('<link>').last
    aux = aux.split('<pubdate>').first
    return aux
  end

  def fetch_header(body)
    aux = body.split('&lt;')[1]
    aux = aux.split('&gt;').last
    return aux
  end

  def fetch_body(body)
    aux = body.split('&gt;').last
    aux = aux.split('</description>').first
    return aux
  end

  def name
    "SoyChile"
  end
end
