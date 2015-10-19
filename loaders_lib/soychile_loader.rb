require './Worker'
require './Postman'
require './adapter'
require './source_lib/soychile'

w = Worker.new(Postman.new, SoyChile.new, Adapter.new)

w.work
