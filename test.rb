require './loader'

adapter = Adapter.new
adapter.clear_pages
while true
  Loader.load("./source_lib/soychile.json")
  sleep(30)
end
