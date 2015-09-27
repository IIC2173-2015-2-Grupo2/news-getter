require './Postman'

class Worker
  attr_accessor :source
  attr_accessor :last_fetch

  def initialize(source)
    @source = source
    @last_fetch = "2000-01-01 00:00:00"
  end

  def work
    news = @source.fetch_news @last_fetch
    news ||= Array.new

    if news.length >0
      @last_fetch = news.first[:time]
      puts "Last Fetch: #{@last_fetch}"
      puts news
      send_news news
    else
      puts "Nothing to send"
    end


  end

  private

  def send_news(news = Array.new)
    news.each do |x|
      options = {
        body: {
          news: x
        }
      }
      Postman.send('/', options)
      puts "News Send"
    end
  end

end
