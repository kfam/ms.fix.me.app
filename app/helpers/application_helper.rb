module ApplicationHelper

	def category_path(category)
		raw("/categories/#{h(category.url_segment)}")
	end

	def product_path(product)
		raw("/products/#{h(product.url_segment)}")
	end
end
