require 'rails_helper'

RSpec.describe Factory do
  describe "#execute" do
    it 'scrapeのメッセージを送信する' do
      pending
      scraping_blue_ship_mock = double('BlueShip scrape')
      allow(execute).to receive(:scrape).and_return(scraping_blue_ship_mock)
      BlueShip.new
      expect(execute).to have_received(:scrape).once
    end
  end
end
