class CreateVariants < ActiveRecord::Migration
  def change
    create_table :variants do |t|
      t.string :sku
      t.integer :product_id
      t.integer :price
      t.integer :weight_in_grams
      t.string :description
      t.string :bay
      t.integer :stock_level_total
      t.integer :stock_level_reserved

      t.timestamps
    end
  end
end
