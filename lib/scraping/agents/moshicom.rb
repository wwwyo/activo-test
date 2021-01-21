class Moshicom < Scraping
  
  def default_url
    "https://moshicom.com/search/?s=1&keyword=&event_start_date=&event_end_date=&entry_status=yes&except_eventup=no&scale=0&day_entry=no&measurement=no&user_id=0&search_type=0&recommend_event=true&recommend_course=true&recommend_facility=true&mode=1&l=100&o=0&m=1&keywords=&amp%3Bdate_start=&amp%3Bdate_end=&amp%3Bdisciplines%5B%5D=11&amp%3Bscale=0&amp%3Bsort=2&amp%3Bdisp_limit=20&amp%3Bmode=1"
  end

  def scrape
    wait.until { driver.find_element(:xpath, "//*[@id='event_search']/div[3]/div[1]/section[2]/div").displayed? }
    documents = driver.find_elements(:xpath, "//*[@id='event_search']/div[3]/div[1]/section[2]/div")
    return parse_node(documents)
  end

  def parse_node(documents)
    documents.map{|node| optimize_to_hash(node)}
  end

  def optimize_to_hash(node)
    {
      organization_name: node.find_element(:xpath, ".//div[4]/dl/dd/div[2]/h4/a").text,
      organization_url:  node.find_element(:xpath, ".//div[4]/dl/dd/div[2]/h4/a").attribute('href'),
      title:             node.find_element(:xpath, ".//h3/a").text,
      job_url:           node.find_element(:xpath, ".//h3/a").attribute('href'),
      event_date:        node.find_element(:xpath, ".//div[1]/div[1]/time").text
    }
  end

  def parse_next_link
    driver.find_element(:xpath, "//*[@id='event_search']/div[3]/div[1]/section[2]/nav/ul/li[17]/a")
  end
end