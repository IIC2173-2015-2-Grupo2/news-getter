require './worker'
require './postman'
require './adapter'
require './source_lib/soychile'

w = Worker.new(Postman.new, SoyChile.new, Adapter.new)

w.work
