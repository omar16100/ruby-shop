module ApplicationHelper
	
	def get_menu_options
		menu_options = ['Products', 'Categories']

		if somebody_signed_in?
      menu_options << 'Profile'
      menu_options << 'Admin' if the_user_is_admin?
		end

		menu_options << 'Github'
	end

  def cart_items_count
    current_user ? @cart.products.count : 0
  end

  private
  
    def somebody_signed_in?
      user_signed_in?
    end

    def the_user_is_admin?
      current_user.admin?
    end
end
