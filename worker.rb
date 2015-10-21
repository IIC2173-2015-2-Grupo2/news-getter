require './Postman'

# this dude does the work of joining the different parts
class Worker
  attr_accessor :source
  attr_accessor :last_fetch
  attr_accessor :postman
  attr_accessor :adapter

  def initialize(postman, source, adapter)
    @postman = postman
    @source = source
    @adapter = adapter
    @last_fetch = @adapter.last_fetch source.name
  end

  def work
    begin
      news = @source.fetch_news @last_fetch
    rescue
      puts "Something went wrong getting the news. Try again later"
    end
    news ||= []

    if news.length > 0
      @last_fetch = news.first[:time]
      @@postman.add_news(news)
      if @@postman.done_fetch
        @adapter.update_last_fetch(@source.name, @last_fetch)
        puts "Success: #{@source.name}  #{@last_fetch}"
      else
        puts "Something went wrong sending the news"
      end
    else
      puts "Nothing to send: #{@source.name}"
    end
  end
end
