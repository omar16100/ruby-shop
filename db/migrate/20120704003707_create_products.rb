class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :qty
      t.integer :price
      t.boolean :on_sale
      t.integer :sale_price

      t.timestamps
    end
  end
end
