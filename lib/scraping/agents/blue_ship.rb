class BlueShip < Scraping

  def default_url
    "https://blueshipjapan.com/search/event/catalog?area=0&amp;text_date=&amp;date=1&amp;text_keyword=&amp;cancelled=0&amp;cancelled=1&amp;order=desc"
  end

  def scrape
    wait.until { driver.find_element(:xpath, "//*[@id='search_result']/div/div/ul/li").displayed? }
    documents = driver.find_elements(:xpath, "//*[@id='search_result']/div/div/ul/li")
    return parse_node(documents)
  end

  private
  def parse_node(documents)
    documents.map{|node| optimize_to_hash(node)}
  end

  def optimize_to_hash(node)
    {
      organization_name: node.find_element(:xpath, ".//div[2]/a/p").text,
      organization_url:  node.find_element(:xpath, ".//div[2]/a").attribute('href'),
      title:             node.find_element(:xpath, ".//div[1]/h2/a").text,
      job_url:           node.find_element(:xpath, ".//div[1]/h2/a").attribute('href'),
      event_date:        node.find_element(:xpath, ".//a/p/span").text
    }
  end

  def parse_next_link
    driver.find_element(:xpath, "//*[@id='search_result']/div/div/div/span/following-sibling::a")
  end
end