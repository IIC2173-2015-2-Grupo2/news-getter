require './worker'
require './Postman'
require './adapter_redis'
require './source_lib/lacuarta'

w = Worker.new(Postman.new, LaCuarta.new, Adapter.new)

w.work
