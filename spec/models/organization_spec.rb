require 'rails_helper'

RSpec.describe Organization, type: :model do
  it "has a valid factory" do
    expect(build(:organization)).to be_valid
  end

  describe 'validation' do
    before do
      @organization = build(:organization)
    end
    it 'forbid to have not unique url' do
      @organization.save
      organization_not_unique = FactoryBot.build(:organization, url: @organization.url)
      organization_not_unique.valid?
      expect(organization_not_unique.errors.full_messages).to include('Url has already been taken')
    end
  end
end