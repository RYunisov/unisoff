class AddCityToProduct < ActiveRecord::Migration
  def change
    add_column :products, :city_id, :integer
  end
end
