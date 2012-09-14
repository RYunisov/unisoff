class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :from
      t.string :to
      t.text :message
      t.integer :status

      t.timestamps
    end
	add_index :messages, :from
	add_index :messages, :to
  end
end
