class BlueShip
  require 'scraping_nokogiri'
  require 'build'

  @@article_num_in_page = 18

  attr_reader :lists, :page_id, :is_next_page?, :datas

  def initialize
    @lists = []
    @page_id = 0
    @is_next_page = true
  end

  def scraping
    while (is_next_page?) do
      @datas = parse_nokogiri_doc
      build
    end
  end

  private

  def build
    build = Build.new(self)
    build.save_database
  end

  def parse_nokogiri_doc
    @datas = find_lists.map{|list| {
      organization_name: get_organization_name(list),
      organization_url: get_organization_url(list),
      title: get_title(list),
      job_offer_url: get_job_offer_url(list),
      event_date: get_event_date(list)
    }}
  end

  def list_present?(list)
    if list.present?
      @page_id += 1
      return true
    else
      @is_next_page? = false
      return false
    end
  end

  def find_lists
    doc = set_nokogiri_doc
    1.upto(@@article_num_in_page) do |i|
      list = doc.xpath("//div[@class='search_data']//li[#{i}]")
      list_present?(list) ? lists << list : break
    end
    return lists
  end

  def get_organization_name(list)
    list.xpath('.//p[@class="crew_name"]').inner_text 
  end

  def get_organization_url(list)
    list.xpath('.//div[@class="crew_info"]/a/@href').text  
  end

  def get_title(list)
    list.xpath('.//h2[@class="event_title"]/a').inner_text
  end

  def get_job_offer_url(list)
    list.xpath('.//h2[@class="event_title"]/a/@href').text
  end

  def get_event_date(list)
    list.xpath('.//p[@class="event_date"]/span').inner_text
  end

  def set_nokogiri_doc
    url = "https://blueshipjapan.com/search/event/catalog?area=0&text_date=&date=1&text_keyword=&cancelled=0&cancelled=1&order=asc&per_page=#{page_id}"
    doc = ScrapingNokogiri.new(url: url).nokogiri_doc
    return doc
  end
end