class DefaultAgent
  # scrapingしたデータの連想配列を返す。
  attr_reader :driver, :wait, :is_next_page, :current_loop_times, :max_loop_times, :url

  def initialize(args={})
    @driver = Selenium::WebDriver.for :chrome
    Selenium::WebDriver.logger.output    = File.join("#{Rails.root}/log/", "selenium.log")
    Selenium::WebDriver.logger.level     = :warn
    driver.manage.timeouts.implicit_wait = args[:wait_time] || default_wait_time
    timeout                              = args[:time_out]  || default_time_out
    @wait                                = Selenium::WebDriver::Wait.new(timeout: timeout)
    # ここまでseleniumの初期化
    @current_loop_times = 0
    @max_loop_times     = args[:max_loop_times] || default_max_loop_times
    @url                = args[:url]            || default_url
    post_initialize(args)
  end

  def execute
    data_hash_lists = []
    driver.get(url)
    begin
      while (true)
        data_hash_lists += scrape
        parse_next_link.click
        avoid_infinite_loop
      end
    rescue Selenium::WebDriver::Error::NoSuchElementError
    # このエラーが出れば成功
      selenium_warn_log("スクレイピング成功")
    rescue => error
      selenium_warn_log(error)
    end
    driver.quit
    return data_hash_lists
  end

  private
  def default_wait_time
    3
  end

  def default_time_out
    6
  end
  
  def default_max_loop_times
    20
  end

  def post_initialize(args)
    nil
  end

  def default_url
    raise NotImprementedError, 
    "#{self.class}では、default_urlメソッドを実装してください。"
  end

  def scrape
    raise NotImprementedError, 
    "#{self.class}では、scrapeメソッドを実装してください。"
  end

  def parse_next_link
    raise NotImprementedError, 
    "#{self.class}では、parse_next_linkメソッドを実装してください。"
  end

  def avoid_infinite_loop
    @current_loop_times += 1
    if current_loop_times >= max_loop_times
      selenium_warn_log('無限ループ')
      exit
    end
  end

  def selenium_warn_log(error)
    Selenium::WebDriver.logger.warn(error)
  end
end