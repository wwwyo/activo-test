require File.expand_path(File.dirname(__FILE__) + "/environment")
set :output, "#{Rails.root}/log/cron.log"

rails_env = ENV['RAILS_ENV'] || :development
# cronを実行する環境変数をセット
set :environment, rails_env

every 1.days, at: '7:00 am' do
  begin
    rake "activo_test:scraping" 
  rescue => e
    Rails.logger.error(e)
    raise e
  end
end