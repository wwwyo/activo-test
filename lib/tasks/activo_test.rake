namespace :activo_test do
  desc "スクレイピングしたデータをdbに保存"
  task :scraping => :environment do 
    Cron.new({agent: BlueShip.new}).build
    Cron.new({agent: Moshicom.new}).build
  end
end
