class Moshicom
  attr_reader :driver, :wait, :url, :is_next_page, :data

  def initialize
    # seleniumを初期化
    Selenium::WebDriver.logger.output = File.join("./", "selenium.log")
    Selenium::WebDriver.logger.level = :warn
    @driver = Selenium::WebDriver.for :chrome
    @driver.manage.timeouts.implicit_wait = 3
    @wait = Selenium::WebDriver::Wait.new(timeout: 6)

    @url = "https://moshicom.com/search/?s=1&keyword=&event_start_date=&event_end_date=&entry_status=yes&except_eventup=no&scale=0&day_entry=no&measurement=no&user_id=0&search_type=0&recommend_event=true&recommend_course=true&recommend_facility=true&mode=1&l=100&o=0&m=1&keywords=&amp%3Bdate_start=&amp%3Bdate_end=&amp%3Bdisciplines%5B%5D=11&amp%3Bscale=0&amp%3Bsort=2&amp%3Bdisp_limit=20&amp%3Bmode=1"
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
        wait.until { driver.find_element(:xpath, "//*[@id='event_search']/div[3]/div[1]/section[2]/div").displayed? }

        scraping_data += driver.find_elements(:xpath, "//*[@id='event_search']/div[3]/div[1]/section[2]/div")
          .map{|element| parse_element(element)}

        next_page_link = driver.find_element(:xpath, "//*[@id='event_search']/div[3]/div[1]/section[2]/nav/ul/li[17]/a")
        next_page_link.click

        # 万が一、ページ構成が変わった時の無限ループ回避
        avoid_loop_20
      end

    rescue Selenium::WebDriver::Error::ElementClickInterceptedError
      # 最後のページまでスクレイピングした時
      puts "スクレイピング成功"
      return scraping_data
    rescue => error
      # TODO 最後のページまでスクレイピングできてない
      p error
      return scraping_data
    end

    driver.quit
  end

  def parse_element(element)
    return {
      organization_name: element.find_element(:xpath, ".//div[4]/dl/dd/div[2]/h4/a").text,
      organization_url:  element.find_element(:xpath, ".//div[4]/dl/dd/div[2]/h4/a").attribute('href'),
      title:             element.find_element(:xpath, ".//h3/a").text,
      job_offer_url:     element.find_element(:xpath, ".//h3/a").attribute('href'),
      event_date:        element.find_element(:xpath, ".//div[1]/div[1]/time").text
    }
  end

  def avoid_loop_20
    @loop_num += 1 
    @is_next_page = false if @loop_num >= 20
  end
end