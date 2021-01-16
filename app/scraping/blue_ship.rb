class BlueShip
  attr_reader :driver, :wait, :url, :is_next_page, :data

  def initialize
    # seleniumを初期化
    Selenium::WebDriver.logger.output = File.join("./", "selenium.log")
    Selenium::WebDriver.logger.level = :warn
    @driver = Selenium::WebDriver.for :chrome
    @driver.manage.timeouts.implicit_wait = 3
    @wait = Selenium::WebDriver::Wait.new(timeout: 6)

    @url = "https://blueshipjapan.com/search/event/catalog?area=0&amp;text_date=&amp;date=1&amp;text_keyword=&amp;cancelled=0&amp;cancelled=1&amp;order=desc"
    @is_next_page = true
    @loop_num = 0
    @data = []
  end

  def fetch_data
    @data = scraping
  end

  private 

  def scraping
    driver.get(url)

    begin
      scraping_data = []

      while (is_next_page)
        wait.until { driver.find_element(:xpath, "//*[@id='search_result']/div/div/ul/li").displayed? }

        scraping_data += driver.find_elements(:xpath, "//*[@id='search_result']/div/div/ul/li")
          .map{|element| parse_element(element)}

        next_page_link = driver.find_element(:xpath, "//*[@id='search_result']/div/div/div/span/following-sibling::a")
        next_page_link.click

        # 万が一、ページ構成が変わった時の無限ループ回避
        avoid_loop_20
      end

    rescue Selenium::WebDriver::Error::NoSuchElementError
      # 最後のページまでスクレイピングした時
      puts "スクレイピング成功"
      return scraping_data
    rescue => error
      p error
    end

    driver.quit
  end

  def parse_element(element)
    return {
      organization_name: element.find_element(:xpath, ".//div[2]/a/p").text,
      organization_url:  element.find_element(:xpath, ".//div[2]/a").attribute('href'),
      title:             element.find_element(:xpath, ".//div[1]/h2/a").text,
      job_offer_url:     element.find_element(:xpath, ".//div[1]/h2/a").attribute('href'),
      event_date:        element.find_element(:xpath, ".//a/p/span").text
    }
  end

  def avoid_loop_20
    @loop_num += 1 
    @is_next_page = false if @loop_num >= 20
  end
end