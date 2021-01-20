class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.string :title,            null: false
      t.string :url,              null: false, unique: true
      t.string :event_date,       null: false
      t.references :organization, foreign_key: true
      t.timestamps
    end
  end
end
