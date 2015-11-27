require './loader'

adapter = Adapter.new
adapter.clear_pages
while true
  Loader.load_pages("http://arquiapi.ing.puc.cl/news")
  sleep(30)
end
