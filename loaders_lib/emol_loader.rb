require './worker'
require './postman'
require './adapter'
require './source_lib/emol'

w = Worker.new(Postman.new, Emol.new, Adapter.new)

w.work
