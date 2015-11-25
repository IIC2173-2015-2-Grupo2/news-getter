# general utilities to parse news
require 'time'
def to_time( year, month,day, time, sec='00')
  x = "#{year}-#{month}-#{day} #{time}:#{sec}"
  x
end

def earlier? (time1, time2)
  Time.parse(time1).to_f < Time.parse(time2).to_f
end

def parse_time time
  Time.parse(time).to_s.chomp(" UTF")
end

def news_builder(title, time, header, url, body, tags)
  {title: "#{title}", time: "#{time}", header: "#{header}", url: "#{url}", body: "#{body}", tags: "#{tags}" }
end

def parse_json(filename)
  file = File.read(filename)
  data_hash = JSON.parse(file)
  data_hash["origin"] =set_time data_hash["origin"]
  data_hash
end

def set_time(string)
  a = string.gsub('#{year}', Date.today.strftime("%Y"))
  b = a.gsub('#{month}', Date.today.strftime("%m"))
  b.gsub('#{day}', Date.today.strftime("%d"))
end

def parse_body body
  aux = ""

  body = body.gsub("<![CDATA[", '')
  body = body.gsub("]]>", '')

  tags = body.split("&lt;")
  if body["<"]
    parser = true;
  end

  if parser
    tags = body.split("<")
    tags.each do |tag|
      if tag != "" && tag[">"]
        tag = tag.split(">")
        if tag.first != tag.last
          aux = aux + tag.last
        end
      elsif tag != ""
        aux = aux + tag
      end
    end
  else
    tags.each do |tag|
      if tag != "" && tag["&gt;"]
        tag = tag.split("&gt;")
        if tag.first != tag.last
          aux = aux + tag.last
        end
      elsif tag != ""
        aux = aux + tag
      end
    end
  end

  aux
end
