namespace :activo_test do
  desc "スクレイピングしたデータをdbに保存"
  task :scraping => :environment do 
    Factory.new({agent: BlueShip.new}).build
    Factory.new({agent: Moshicom.new}).build
  end
end
