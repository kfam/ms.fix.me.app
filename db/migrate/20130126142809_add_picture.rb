class AddPicture < ActiveRecord::Migration
  def change
    add_attachment :products, :picture
    add_attachment :categories, :picture
  end
end
