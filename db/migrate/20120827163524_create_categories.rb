class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string  :param_name
      t.timestamps
    end
  end
end
