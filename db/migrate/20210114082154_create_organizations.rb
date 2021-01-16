class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations do |t|
      t.string :name,       null: false, index: true
      t.string :url,        null: false, unique: true
      t.boolean :is_checked, default: false
      t.timestamps
    end
  end
end
