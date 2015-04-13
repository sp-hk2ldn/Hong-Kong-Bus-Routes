class AddFromAndToToRoute < ActiveRecord::Migration
  def change
    add_column :routes, :from_where, :string
    add_column :routes, :to_where, :string
  end
end
