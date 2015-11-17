# Loader
require './Postman'
require './worker'
require './source'
require './adapter_redis'

adapter = Adapter.new
adapter.clear_pages
while(true)
  worker_pages = Worker.new(Postman.new, Source.new("http://arquiapi.ing.puc.cl/news"), adapter)
  worker_pages.work_pages
  #sleep 60
end