class Page < ActiveRecord::Base
  attr_accessible :name, :content
  
  before_save do |page|
    page.url = page.name.split(/\s/).join("-")
  end
  
end
