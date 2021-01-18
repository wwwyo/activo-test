class Job < ApplicationRecord
  # association
  belongs_to :organization

  # validation
  with_options presence: true do
    validates :title
    validates :url, uniqueness: true
    validates :event_date
  end  
end
