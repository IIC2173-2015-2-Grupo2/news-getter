require 'nokogiri'
require 'open-uri'
require 'date'
require 'time'
require './source_lib/utilities'


class Emol
  def fetch_news(last_fetch = "#{Date.today.to_s} 00:00:00")
    news = Array.new
    year  = Date.today.strftime("%Y")
    month = Date.today.strftime("%m")
    day = Date.today.strftime("%d")

    doc = Nokogiri::HTML(open("http://www.emol.com/noticias/#{year}/#{month}/#{day}"))

    news = doc.xpath("//li[contains(@id, 'cuTodas_ucCajaTodas_ListadoNoticias')]").collect do |node|
      time = node.xpath("div[contains(@class, 'hora_listado')]/text()")
      title = node.xpath("div[contains(@class, 'listado')]/a/text()")
      header = node.xpath("div[contains(@class, 'listado')]/span/text()")
      url = node.xpath("div[contains(@class, 'listado')]/a/@href")
      tags = ""

      time = to_time(year, month, day, time.to_s)
      break if !earlier?(last_fetch, time)

      doc2 = Nokogiri::HTML(open(url.to_s))
      body = fetch_body doc2

      noticia = {title: "#{title}", time: "#{time}", header: "#{header}", url: "#{url}", body: "#{body}", tags: "#{tags}" }

      noticia
    end
    news
  end

  def fetch_body(body)
    aux = body.xpath("//div[contains(@id, 'cuDetalle_cuTexto_textoNoticia')]").first
    aux = parseBody aux.to_s
    return aux
  end
  def name
    "Emol"
  end
end
