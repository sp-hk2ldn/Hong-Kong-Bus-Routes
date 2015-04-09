class AddRouteIdToDetails < ActiveRecord::Migration
  def change
    add_column :details, :route_id, :integer
  end
end
