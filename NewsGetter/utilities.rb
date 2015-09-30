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

def parseEmolBody body
	aux = ''
	aux2 = body.gsub("<br>", '')
	aux2 = aux2.to_s.split("<")
	aux2.each do |a|
		aux3 = ''
		aux3 = a.to_s.split(">").last
		aux = aux + aux3.to_s
	end
	aux = aux.to_s.gsub("/div", '')
	aux
end

def parseGuardianHeader header
	aux = header.gsub("&lt;p&gt;", '')
	aux = aux.gsub("&lt;/p&gt;", ".")
	aux = aux.split("&lt;a")[0]
	aux
end
def parseCNNHeader header
	aux = header.to_s.split("&lt;br clear='all'").first
	aux
end
def parseTerceraHeader header
	aux = header.split("> ").last
	aux = aux.to_s.gsub("]]&gt", '')
	aux = aux.to_s.gsub(";", '')
	aux
end