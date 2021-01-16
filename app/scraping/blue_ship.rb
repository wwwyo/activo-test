class BlueShip
  attr_reader :driver, :wait, :url, :data

  def initialize
    # seleniumを初期化
    Selenium::WebDriver.logger.output = File.join("./", "selenium.log")
    Selenium::WebDriver.logger.level = :warn
    @driver = Selenium::WebDriver.for :chrome
    @driver.manage.timeouts.implicit_wait = 3
    @wait = Selenium::WebDriver::Wait.new(timeout: 6)

    @url = "https://blueshipjapan.com/search/event/catalog?area=0&amp;text_date=&amp;date=1&amp;text_keyword=&amp;cancelled=0&amp;cancelled=1&amp;order=desc"
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

      while (true)
        wait.until { driver.find_element(:xpath, "//*[@id='search_result']/div/div/ul/li").displayed? }

        scraping_data += driver.find_elements(:xpath, "//*[@id='search_result']/div/div/ul/li")
          .map{|element| parse_element(element)}

        next_page_link = driver.find_element(:xpath, "//*[@id='search_result']/div/div/div/span/following-sibling::a")
        next_page_link.click
      end

    rescue Selenium::WebDriver::Error::NoSuchElementError
      # 最後のページまでスクレイピングした時
      puts "スクレイピング成功"
    rescue => error
      p error
    end

    driver.quit
    return scraping_data
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
end