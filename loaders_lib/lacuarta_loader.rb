require './Worker'
require './Postman'
require './adapter'
require './source_lib/lacuarta'

w = Worker.new(Postman.new, LaCuarta.new, Adapter.new)

w.work
