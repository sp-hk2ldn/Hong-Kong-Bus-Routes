class AddDirectionAndCompanyToRoute < ActiveRecord::Migration
  def change
    add_column :routes, :direction, :string
    add_column :routes, :company, :string
  end
end
