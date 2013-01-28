class Administration::HomeController < Administration::AdministrationController

	def home
    @page = Page.where(:name => "home").first
    if @page
      render :template => 'pages/show_page'
    else
      
    end
	end
	
end	
