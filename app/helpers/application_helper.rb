module ApplicationHelper
	
	def get_menu_options
		menu_options = ['Products', 'Categories']

		if user_signed_in?
			menu_options << 'Admin' if current_user.admin?
		end

		menu_options << 'Profile'
		menu_options << 'About'
	end

  def cart_items_count
    cart = Cart.find_by_user_id(current_user.id)
    cart ||= Cart.new
    cart.products.size
  end
end
