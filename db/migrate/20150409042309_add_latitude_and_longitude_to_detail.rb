class AddLatitudeAndLongitudeToDetail < ActiveRecord::Migration
  def change
    add_column :details, :latitude, :string
    add_column :details, :longitude, :string
  end
end
