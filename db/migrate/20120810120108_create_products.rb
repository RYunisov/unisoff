class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string  :title
      t.text  :content
      t.integer :price
      t.integer :user_id
      t.string  :phone

      t.timestamps
    end
   add_index :products, :user_id
   add_index :products, :created_at
  end
end
