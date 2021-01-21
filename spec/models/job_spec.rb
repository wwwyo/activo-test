require 'rails_helper'

RSpec.describe Job, type: :model do
  describe 'validation' do
    before do
      @job = FactoryBot.build(:job)
    end
    it '求人が重複して登録されない' do
      @job.save
      job_not_unique = FactoryBot.build(:job)
      job_not_unique.url = @job.url
      job_not_unique.valid?
      expect(job_not_unique.errors.full_messages).to include('Url has already been taken')
    end

    it '団体に紐づいてない求人は登録されない' do
      job = Job.new(title: "求人", url: "https://kyuuzin.co.jp", event_date: "2020-1-23")
      job.valid?
      expect(job.errors.full_messages).to include('Organization must exist')
    end
  end
end
