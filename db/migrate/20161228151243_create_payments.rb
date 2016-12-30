class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.belongs_to :order, foreign_key: true
      t.decimal :amount, precision: 8, scale: 2
      t.string :external_id
      t.string :status

      t.timestamps
    end
    add_index :payments, :external_id
  end
end
