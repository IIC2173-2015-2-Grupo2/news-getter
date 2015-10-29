require './adapter_redis'

class MobileCode
  def self.add_source(file)
    a = Adapter.new
    File.write("#{Dir.pwd}/source_lib/source#{a.source_count}.json", file)
    a.new_source("#{Dir.pwd}/source_lib/source#{a.source_count}.json")
  end
end
