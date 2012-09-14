class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :param_name

      t.timestamps
    end
	add_index :cities, :param_name, :unique => true
  end
end
