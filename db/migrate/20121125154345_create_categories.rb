class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :url_segment
      t.integer :published_status
      t.integer :parent_category_id
      t.text :description
      t.string :meta_keywords
      t.string :meta_description

      t.timestamps
    end
  end
end
