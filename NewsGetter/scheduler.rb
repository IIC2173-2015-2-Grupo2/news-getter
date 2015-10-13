require './Worker'
require './Postman'
require './emol'
require './theguardian'
require './cnn'
require './latercera'
require './nytimes'

class Scheduler

  def start
    @postman = Postman.new

    worker1 = Worker.new(@postman, Emol.new)
    worker2 = Worker.new(@postma, TheGuardian.new)
    worker3 = Worker.new(@postman, CNN.new)
    worker4 = Worker.new(@postman, LaTercera.new)
    worker5 = Worker.new(@postman, NYTimes.new)

    while true
      worker1.work
      worker2.work
      worker3.work
      worker4.work
      worker5.work

      @postman.done_fetch
      sleep(1000)
    end

  end
end

director = Scheduler.new

director.start
