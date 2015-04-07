class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :routenumber
      t.string :route_from_to
      t.string :cost

      t.timestamps
    end
  end
end
