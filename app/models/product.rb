class Product < ActiveRecord::Base
  
  attr_accessible :description, 
    :meta_description, 
    :meta_keywords, 
    :name, :published_status, 
    :strapline, :subcode, 
    :url_segment, 
    :picture,
    :variants_attributes
        
  has_attached_file :picture, :styles => { :large => "500x330>", :thumb => "100X67>" }

  has_many :variants

  accepts_nested_attributes_for :variants

  has_and_belongs_to_many :categories

  acts_as_publishable

  def self.random_best_sellers(number)
  	find(:all, :limit => number, :order => 'RAND()')
  end
end
