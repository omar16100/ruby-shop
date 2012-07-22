module ApplicationHelper
	
	def get_menu_options
		menu_options = ['Products', 'Categories']

		if user_signed_in?
			menu_options << 'Admin' if current_user.admin?
		end

		menu_options << 'Profile'
		menu_options << 'Github'
	end

  def cart_items_count
    current_user ? @cart.products.count : 0
  end
end
