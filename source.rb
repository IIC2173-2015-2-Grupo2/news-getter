# Source
require 'nokogiri'
require 'open-uri'
require 'json'
require 'date'
require './source_lib/utilities'
require './adapter_redis'

# Source strategy
class Source

  attr_accessor :filename
  attr_accessor :extras
  attr_accessor :news_fetched
  attr_accessor :page_news
  attr_accessor :last_id
  attr_accessor :num_news

  def initialize(filename)
    @filename = filename
    @extras = ["body", "tags", "special", "image"]
    @page_news = []
    @num_news = ENV['NUM_NEWS'].to_i
    @num_news = 300 if @num_news== 0
  end

# main method to fetch news
  def fetch_news(last_fetch = "#{Date.today} 00:00:00")
    x = build_news(parse_json(@filename), last_fetch)
  end

# here it will build an array with the next 300 news
  def fetch_page(data, adapter)
    last_fetched = adapter.get_last_fetched
    pages = get_json(data.to_s + "?page=" + last_fetched[:page].to_s + "&limit=10")

    if pages["next"].nil?
      next_page = 0
    else
      next_page = 1
    end

    news = pages["news"]

    add_news = 0

    news.each do |news_node|
      href = news_node["href"]
      return @page_news unless (@page_news.count < @num_news)
      @page_news << fetch_news_json(href)
      add_news = add_news + 1
    end

    adapter.update_last_value(last_fetched[:value].to_i + add_news)
    adapter.update_last_page(last_fetched[:page].to_i + next_page)

    fetch_page(data, adapter)
  end

# method used to create the json with news info
  def fetch_news_json(data)
    x = get_json("http://" + data)
    @last_id = x["id"]
    news = {
      title: x["title"].to_s, time: x["date"].to_s,
      header: "null", url: "http://#{x['href'].to_s}", imageUrl: "null",
      source: "ArquiAPI", body: x["body"].to_s,
      tags: [x["category"].to_s, x["author"].to_s], language: "en"
    }
    return news
  end

  # here it builds the news array
  def build_news(data, last_fetch)
    doc = Nokogiri::HTML(open(data["origin"]))
    news = doc.xpath(data["news"]).collect do |node|
      x = collect_news_item(node, data)
      time = parse_time x["time"].to_s
      x["time"] = time.to_s
      break unless earlier?(last_fetch, time)
      x
    end
    news
  end

# method used to get the json from a specific url
  def get_json(url)
    open(url) {|f|
      f.each_line {|line|
        pages = JSON.parse(line)
        return pages
      }
    }
  end

# collect a particular news
  def collect_news_item(node, data)
    h = Hash[data.keys[2..5].map { |x| [x, node.xpath(data[x]).to_s] }]
    h["title"] = replace_vocals h["title"].gsub(/[^a-zA-Z0-9áéíóúÁÉÍÓÚÑñ&* ]/, "")
    h["header"] = replace_vocals h["header"].gsub(/[^a-zA-Z0-9áéíóúÁÉÍÓÚÑñ&* ]/, "")
    get_extras(h, node, data)
  end

# gets te rest of the important stuff
  def get_extras(hash, node, data)
    hash["body"] = get_body(hash["url"], data["body"])
    hash["body"] = hash["header"] if hash["body"].nil?
    hash["body"] = clean_news(hash)
    hash["tags"] = Array.new
    hash["tags"] = fetch_tags(hash["url"], data["tags"]) if data["tags"].last
    hash["url"] = fetch_url(node.to_s) if data["special"]
    hash["source"] = data["source"]
    hash["language"] = data["language"]
    aux = data["image"]
    if !aux.nil?
      hash["imageUrl"] = get_image(hash["url"], aux) unless aux[0] == 0
    else
      hash["imageUrl"] = ""
    end
    hash["imageUrl"] = get_any_image(hash["url"], data) if hash["imageUrl"] == ""
    hash["imageUrl"] = data["aux_image"] if hash["imageUrl"].nil?
    hash
  end

  def clean_news(hash)
    hash["body"] = parse_body(hash["body"])
    hash["body"] = hash["body"].gsub(/[^a-zA-Z0-9áéíóúÁÉÍÓÚÑñ&*., ]/,"")  unless hash["body"].nil?
    hash["body"] = replace_vocals hash["body"]
    puts hash["body"]
    hash["body"]
  end
# gets the url of some sources
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
    parse_body doc.xpath(body[0]).first.to_s
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

  def get_any_image(url, data)
    x = ""
    begin
      doc = Nokogiri::HTML(open(url))
      x = doc.xpath("//img[contains(@src, 'http')]/@src").first.to_s
    rescue
    end
    x = data["aux_image"] if x.nil?
    x
  end

  def replace_vocals(string)
    string = string.gsub('á', 'a')
    string = string.gsub('é', 'e')
    string = string.gsub('í', 'i')
    string = string.gsub('ó', 'o')
    string = string.gsub('ú', 'u')
    string = string.gsub('Á', 'A')
    string = string.gsub('É', 'E')
    string = string.gsub('Í', 'I')
    string = string.gsub('Ó', 'O')
    string = string.gsub('Ú', 'U')
    string
  end

# returns its name
  def name
    @filename
  end

end
