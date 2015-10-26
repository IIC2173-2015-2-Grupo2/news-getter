require './worker'
require './Postman'
require './adapter_redis'
require './source_lib/cnn'

w = Worker.new(Postman.new, CNN.new, Adapter.new)

w.work
