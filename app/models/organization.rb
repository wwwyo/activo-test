class Organization < ApplicationRecord
  # association
  has_many :job_offers

  # validation
  with_options presence: true do
    validates :name
    validates :url,      uniqueness: true
  end
  validates :is_checked, inclusion: {in: [true, false]}
end
