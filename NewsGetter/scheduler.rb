require './Worker'
require './emol'
require './theguardian'
require './cnn'
require './latercera'
require './nytimes'

class Scheduler

  def start
    worker1 = Worker.new Emol.new
    worker2 = Worker.new TheGuardian.new
    worker3 = Worker.new CNN.new
    worker4 = Worker.new LaTercera.new
    worker5 = Worker.new NYTimes.new

    while true
      worker1.work
      worker2.work
      worker3.work
      worker4.work
      worker5.work
      sleep(1000)
    end


  end
end

director = Scheduler.new

director.start
