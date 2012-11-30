class Variant < ActiveRecord::Base
  attr_accessible :bay, :description, :price, :product_id, :sku, :stock_level_reserved, :stock_level_total, :weight_in_grams

  belongs_to :product

  def buyable?
  	stock_level_available > 0
  end

  def stock_level_available
  	stock_level_total - stock_level_reserved
  end

end
