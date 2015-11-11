class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.integer :locationable_id
      t.string :locationable_type

      t.timestamps null: false
    end
  end
end
