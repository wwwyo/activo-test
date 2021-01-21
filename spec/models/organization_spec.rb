require 'rails_helper'

RSpec.describe Organization, type: :model do
  describe 'validation' do
    before do
      @organization = FactoryBot.build(:organization)
    end
    it '団体が重複して登録されない' do
      @organization.save
      organization_not_unique = FactoryBot.build(:organization)
      organization_not_unique.url = @organization.url
      organization_not_unique.valid?
      expect(organization_not_unique.errors.full_messages).to include('Url has already been taken')
    end
  end
end
