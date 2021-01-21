class Organization < ApplicationRecord
  # association
  has_many :jobs

  # validation
  with_options presence: true do
    validates :name
    validates :url, uniqueness: true
  end
  validates :is_checked, inclusion: {in: [true, false]}
  
  def iterate_find_or_create(data_hash_lists)
    data_hash_lists.each do |list|
      Organization.find_or_create_by(list)
    end
  end

  def find_id_by_url(url)
    organization = Organization.find_by(url: url)
    organization.id
  end
end