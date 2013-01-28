class PagesController < ShopController
  
  RESTRICTED_PAGES = ["home", "public-home"]
  
  def show_page
    unless RESTRICTED_PAGES.include? params[:a]
      @page = Page.find_by_url( params[:a] )
    end
  end
end
