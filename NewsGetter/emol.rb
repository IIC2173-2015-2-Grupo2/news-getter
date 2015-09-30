require 'nokogiri'
require 'open-uri'
require 'date'
require 'time'
require './utilities'


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

        doc2 = Nokogiri::HTML(open(url.to_s))
        body = doc2.xpath("//div[contains(@id, 'cuDetalle_cuTexto_textoNoticia')]").first
        
        time2 = to_time(year, month, day, time.to_s)
        body2 = parseEmolBody body.to_s
        break if !earlier?(last_fetch, time2)

        noticia = {title: "#{title}", time: "#{time2}", header: "#{header}", url: "#{url}" , body: "#{body2}"}

        noticia
      end
      news
    end
end
