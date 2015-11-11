class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :color
      t.integer :class
      t.integer :ticket_no
      t.integer :location_id
    end
  end
end
