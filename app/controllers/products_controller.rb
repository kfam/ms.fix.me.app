class ProductsController < ShopController
	def show
		@product = Product.find_by_url_segment(params[:url_segment])
	end
end
