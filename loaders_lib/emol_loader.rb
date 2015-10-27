require './worker'
require './Postman'
require './adapter_redis'
require './source_lib/emol'

w = Worker.new(Postman.new, Emol.new, Adapter.new)

w.work
