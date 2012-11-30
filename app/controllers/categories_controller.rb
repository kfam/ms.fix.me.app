class CategoriesController < ShopController
	def show
		@category = Category.public_viewable.find_by_url_segment(params[:url_segment])
	end
end
