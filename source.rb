# Source
require 'nokogiri'
require 'open-uri'
require 'json'
require 'date'
require './source_lib/utilities'

# Source strategy
class Source

  attr_accessor :filename
  attr_accessor :extras

  def initialize(filename)
    @filename = filename
    @extras = ["body", "tags", "special", "image"]
  end

# main method to fetch news
  def fetch_news(last_fetch = "#{Date.today.to_s} 00:00:00")
    x = build_news(parse_json(@filename), last_fetch)
  end

# here it builds the news array
  def build_news(data, last_fetch)
    doc = Nokogiri::HTML(open(data["origin"]))
    news = doc.xpath(data["news"]).collect do |node|
      x = collect_news_item(node, data)
      time = parseTime x["time"].to_s
      puts last_fetch
      break if !earlier?(last_fetch, time)
      x
    end
    news
  end

# collect a particular news
  def collect_news_item(node, data)
    h = Hash[data.keys[2..5].map {|x| [x, node.xpath(data[x]).to_s]}]
    get_extras(h, node, data)
  end

# gets te rest of the important stuff
  def get_extras(hash, node, data)
    hash["body"] = get_body(hash["url"], data["body"])
    hash["tags"] = fetch_tags(hash["url"], data["tags"]) if data["tags"].last
    hash["url"] = fetch_url(node.to_s) if data["special"]
    aux = data["image"]
    if aux != nil
      hash["image"] = get_image(hash["url"], aux) unless aux[0] == 0
    end
    hash
  end
  def fetch_url(body)
    aux = body.split('<link>').last
    aux = aux.split('<pubdate>').first
    aux
  end

# get the body of a news
  def get_body(url, body)
    begin
    doc = Nokogiri::HTML(open(url))
    aux = ""
    if body[1]
      aux = get_body1(doc, body)
    else
      aux = get_body2(doc, body)
    end
    rescue
      puts "could not find body"
    end
    aux
  end

  def get_body1(doc, body)
    parseBody doc.xpath(body[0]).first.to_s
  end

  def get_body2(doc, body)
    aux = ""
    doc.xpath(body[0]).each do |p|
      aux = aux + p.text + '\n'
    end
    aux
  end

  def get_image(url, image)
    doc = Nokogiri::HTML(open(url))
    get_image1(doc, image[0]) if image[1] == 1
    get_image2(doc, image[0]) if image[1] == 2
  end

# first way of getting images
  def get_image1(doc, image)
    x = doc.xpath(image).to_s
  end
  # second way of geeting images
  def get_image2(doc, image)
    x = doc.xpath(image).first.to_s
  end

# fetch tags if possible
  def fetch_tags(url, tags)
    doc = Nokogiri::HTML(open(url))
    aux = []
    doc.xpath(tags).each do |f|
      aux << f.text
    end
    return aux
  end

# returns its name
  def name
    @filename
  end

end
