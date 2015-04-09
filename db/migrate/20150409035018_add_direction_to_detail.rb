class AddDirectionToDetail < ActiveRecord::Migration
  def change
    add_column :details, :travel_direction, :string
  end
end
