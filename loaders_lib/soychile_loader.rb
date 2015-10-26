require './worker'
require './Postman'
require './adapter_redis'
require './source_lib/soychile'

w = Worker.new(Postman.new, SoyChile.new, Adapter.new)

w.work
