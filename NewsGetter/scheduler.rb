require './Worker'
require './emol'

class Scheduler

  def start
    worker1 = Worker.new Emol.new
    worker2 = Worker.new TheGuardian.new
    while true

      worker1.work
      sleep(3)
      worker2.work
      sleep(3)
    end


  end
end

director = Scheduler.new

director.start
