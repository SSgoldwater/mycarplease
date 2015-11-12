class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :color
      t.string :style
      t.integer :ticket_no
      t.string  :space
      t.integer :location_id
    end
  end
end
