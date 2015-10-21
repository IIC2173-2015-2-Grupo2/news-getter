require './worker'
require './Postman'
require './adapter'
require './source_lib/cnn'

w = Worker.new(Postman.new, CNN.new, Adapter.new)

w.work
