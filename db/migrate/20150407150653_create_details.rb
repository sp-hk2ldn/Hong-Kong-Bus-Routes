class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details do |t|
      t.integer :stop_number
      t.string :stop_name
      t.string :stop_location
      t.string :area
      t.string :adult_price
      t.string :child_price
      t.string :senior_price

      t.timestamps
    end
  end
end
