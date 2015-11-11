class AddLocationIdToEmployees < ActiveRecord::Migration
  def change
    add_reference :employees, :location, index: true
  end
end
