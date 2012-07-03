module ApplicationHelper
	
	def get_menu_options
		menu_options = ['Home', 'Catalog']

		if user_signed_in?
			menu_options << 'Products'
			menu_options << 'Admin' if current_user.admin?
		end

		menu_options << 'Profile'
		menu_options << 'About'
	end
end
