class ShopController < ApplicationController
	before_filter :load_root_categories

	private

	def load_root_categories
		@root_categories = Category.published.roots
	end
end