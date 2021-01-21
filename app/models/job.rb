class Job < ApplicationRecord
  # association
  belongs_to :organization

  # validation
  with_options presence: true do
    validates :title
    validates :url, uniqueness: true
    validates :event_date
  end

  def iterate_find_or_create(data_hash_lists)
    data_hash_lists.each do |list|
      Job.find_or_create_by(list)
    end
  end
end
