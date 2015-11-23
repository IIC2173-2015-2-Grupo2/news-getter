# Loader
require './Postman'
require './worker'
require './source'
require './adapter_redis'

# this class starts the wrokers
class Loader

  def self.load(filename)
    worker = Worker.new(Postman.new, Source.new(filename), Adapter.new)
    worker.work
  end

  def self.load_pages(src)
    worker_pages = Worker.new(Postman.new, Source.new(src), Adapter.new)
    worker_pages.work_pages
  end
end
