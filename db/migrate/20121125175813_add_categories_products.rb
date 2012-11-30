class AddCategoriesProducts < ActiveRecord::Migration
  def change
    create_table :categories_products do |t|
      t.integer :category_id
      t.integer :product_id
      t.integer :position
    end
  end
end
