require './worker'
require './Postman'
require './adapter_redis'
require './source_lib/latercera'

w = Worker.new(Postman.new, LaTercera.new, Adapter.new)

w.work
