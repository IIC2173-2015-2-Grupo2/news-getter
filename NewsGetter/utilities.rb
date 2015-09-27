require 'time'
def to_time( year, month,day, time, sec='00')

  x = "#{year}-#{month}-#{day} #{time}:#{sec}"
  x
end

def earlier? (time1, time2)
  Time.parse(time1).to_f < Time.parse(time2).to_f
end

def parseGuardianTime time
  Time.parse(time).to_s.chomp(" UTC")
end
def parseGuardianHeader header
  aux = header.gsub("&lt;p&gt;", '')
  aux = aux.gsub("&lt;/p&gt;", ".")
  aux = aux.split("&lt;a")[0]
  aux

end
