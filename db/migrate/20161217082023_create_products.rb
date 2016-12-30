class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.timestamps

      t.string :asin
      t.string :name
      t.decimal :price, precision: 8, scale: 2
      t.text :description
      t.string :brand
      t.string :category_name
      t.attachment :image
      t.integer :stock, default: 0
    end
  end
end
