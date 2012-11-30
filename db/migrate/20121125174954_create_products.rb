class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :url_segment
      t.integer :published_status
      t.string :subcode
      t.text :description
      t.string :strapline
      t.string :meta_keywords
      t.string :meta_description

      t.timestamps
    end
  end
end
