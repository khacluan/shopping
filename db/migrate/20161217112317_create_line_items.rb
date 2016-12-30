class CreateLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :line_items do |t|
      t.timestamps

      t.string :purchase_type, index: true
      t.belongs_to :product, foreign_key: true
      t.belongs_to :order, foreign_key: true
      t.integer :quantity, default: 0
      t.decimal :price, precision: 8, scale: 2
    end
  end
end
