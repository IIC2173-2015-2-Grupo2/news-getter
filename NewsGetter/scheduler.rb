require './Worker'
require './emol'
require './theguardian'
require './cnn'
require './latercera'

class Scheduler

  def start
    worker1 = Worker.new Emol.new
    worker2 = Worker.new TheGuardian.new
    worker3 = Worker.new CNN.new
    worker4 = Worker.new LaTercera.new

    while true
      worker1.work
      sleep(3)
      worker2.work
      sleep(3)
      worker3.work
      sleep(3)
      worker4.work
      sleep(3)
    end


  end
end

director = Scheduler.new

director.start
