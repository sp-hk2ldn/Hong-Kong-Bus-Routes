class AddSpecialToRoute < ActiveRecord::Migration
  def change
    add_column :routes, :special, :string
  end
end
