require './Postman'

class Worker
  attr_accessor :source
  attr_accessor :last_fetch
  attr_accessor :postman

  def initialize(postman, source)
    @@postman = postman
    @source = source
    @last_fetch = "2000-01-01 00:00:00"
  end

  def work
    news = @source.fetch_news @last_fetch
    news ||= Array.new

    if news.length >0
      @last_fetch = news.first[:time]
      @@postman.add_news(news)
    else
      puts "Nothing to send"
    end
  end

end
