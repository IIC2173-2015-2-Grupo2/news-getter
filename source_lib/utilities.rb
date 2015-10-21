require 'time'
def to_time( year, month,day, time, sec='00')
	x = "#{year}-#{month}-#{day} #{time}:#{sec}"
	x
end

def earlier? (time1, time2)
	Time.parse(time1).to_f < Time.parse(time2).to_f
end

def parseTime time
	Time.parse(time).to_s.chomp(" UTC")
end

def parseHeader header
	aux = ""

	header = header.gsub("<![CDATA[", '')
	header = header.gsub("]]>", '')

	tags = header.split("&lt;")
	if header["<"]
		parser = true;
	end

	if parser

		tags = header.split("<")
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

def parseBody body
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
