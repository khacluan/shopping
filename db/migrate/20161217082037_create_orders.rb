class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.timestamps

      t.belongs_to :user, foreign_key: true
      t.integer :country_id, index: true
      t.integer :city_id, index: true
      t.integer :district_id, index: true
      t.string :ward_id, index: true
      t.string :ip_address
      t.string :status
      t.string :name
      t.string :phone
      t.string :address, limit: 400
      t.string :street
      t.string :note
      t.boolean :gift, default: false
      t.decimal :shipping_price, precision: 8, scale: 2
      t.decimal :tax_price, precision: 8, scale: 2
      t.decimal :discounted_price, precision: 8, scale: 2
      t.decimal :subtotal_price, precision: 8, scale: 2
      t.decimal :total_price, precision: 8, scale: 2
    end
  end
end
