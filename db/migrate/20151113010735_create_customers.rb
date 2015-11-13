class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :phone
      t.string :name
      t.integer :ticket_no
      t.integer :text_confirmation
      t.references :location, index: true

      t.timestamps null: false
    end
  end
end
