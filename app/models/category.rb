class Category < ActiveRecord::Base
  attr_accessible :description, 
  :meta_description, :meta_keywords, 
  :name, :parent_category_id, 
  :published_status, :url_segment,
  :picture, :products_attributes
  
  has_and_belongs_to_many :products, :order => 'categories_products.position'

  belongs_to :parent, :class_name => 'Category', :foreign_key => :parent_category_id
  has_many :children, :class_name => 'Category', :foreign_key => :parent_category_id

  scope :roots, :conditions => {:parent_category_id => nil}

  has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  accepts_nested_attributes_for :products
  

  acts_as_publishable

end
