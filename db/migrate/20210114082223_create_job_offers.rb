class CreateJobOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :job_offers do |t|
      t.string :title,            null: false
      t.string :url,              null: false, unique: true
      t.date :event_date,         null: false
      t.references :organization, foreign_key: true
      t.timestamps
    end
  end
end
