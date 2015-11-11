class AddLocationIdToEmployees < ActiveRecord::Migration
  def change
    add_reference :employees, :location_id, index: true
  end
end
