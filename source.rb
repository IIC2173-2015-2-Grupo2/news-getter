# Source
require 'nokogiri'
require 'open-uri'
require 'json'
require 'date'
require './source_lib/utilities'

class Source

  attr_accessor :filename

  def initialize(filename)
    @filename = filename
  end

  def fetch_news(last_fetch = "#{Date.today.to_s} 00:00:00")
    x = build_news(parse_json(@filename), last_fetch)
  end

  def build_news(data, last_fetch)
    doc = Nokogiri::HTML(open(data["origin"]))
    news = doc.xpath(data["news"]).collect do |node|
      x = collect_news_item(node, data)
      time = parseTime x["time"].to_s
      break if !earlier?(last_fetch, time)
      x
    end
    news
  end


  def collect_news_item(node, data)
    h = Hash[data.keys[2..-1].map {|x| [x, node.xpath(data[x]).to_s] if( x !="body" or x != "tags")}]
    h["body"] = get_body(h["url"], data["body"])
    h["tags"] = fetch_tags(h["url"], data["tags"]) if data["tags"].last
    h
  end

  def get_body(url, body)
    begin
    doc = Nokogiri::HTML(open(url))
    aux = ""
    if body[1]
      aux = parseBody doc.xpath(body[0]).first.to_s
    else
      aux = ""
      doc.xpath(body[0]).each do |p|
        aux = aux + p.text + '\n'
      end
      aux
    end
    rescue
      puts "could not find body"
    end
  end

  def fetch_tags(url, tags)
    doc = Nokogiri::HTML(open(url))
    aux = []
    doc.xpath(tags).each do |f|
      aux << f.text
    end
    return aux
  end


  def name
    @filename
  end

end
