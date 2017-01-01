class CreateUnits < ActiveRecord::Migration[5.0]
  def change
    create_table :units do |t|
      t.timestamps

      t.string :name,       index: true
      t.string :code,       index: true
      t.string :stand_for,  index: true
      t.string :post_code
      t.string :area_number
      t.string :slug,       index: true
      t.string :unit_type,  index: true
      t.string :ancestry,   index: true
    end
  end
end
