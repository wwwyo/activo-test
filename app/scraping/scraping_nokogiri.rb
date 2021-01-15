class ScrapingNokogiri
  require 'open-uri'

  attr_reader :url, :nokogiri_doc

  def initialize(arg)
    @url = arg[:url]
    @nokogiri_doc = html_convert_to_nokogiri
  end

  private 

  def html_convert_to_nokogiri
    puts "のこぎりsleep"
    sleep 5
    doc = Nokogiri::HTML.parse(fetch_html, nil, 'utf-8')
    return br_tag_replace(doc)
  end

  def fetch_html
    open(url) {|f| f.read}
  end

  def br_tag_replace(doc)
    doc.search('br').each { |br| br.replace("\n")}
  end
end