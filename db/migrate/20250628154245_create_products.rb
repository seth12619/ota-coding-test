class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.decimal :price, precision: 8, scale: 2, null: false
      t.timestamps
    end
    add_index :products, :code, unique: true
  end
end