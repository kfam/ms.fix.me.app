class HomeController < ShopController

	def home
	  @chunk_of_text = Page.find_by_name("public home")
		@products = Product.public_viewable.random_best_sellers(20)
	end

end