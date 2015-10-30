# Loader
require './Postman'
require './worker'
require './source'
require './adapter_redis'

# this class starts the wrokers
class Loader

  def self.load(filename)
    w = Worker.new(Postman.new, Source.new(filename), Adapter.new)
    w.work
  end

end
