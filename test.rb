require './loader'
require './adapter_redis'

adapter = Adapter.new
adapter.clear_pages
adapter.create_db
while true
  Loader.load("./source_lib/emol.json")
  sleep(30)
end
