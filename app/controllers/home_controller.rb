class HomeController < ShopController

	def home
		@products = Product.public_viewable.random_best_sellers(20)
	end

end