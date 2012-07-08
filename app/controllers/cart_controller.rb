class CartController < ApplicationController
  
  # authorize_resource

  # GET /cart
  def index
    @user_cart = Cart.find_by_user_id(params[:user_id])

    unless @user_cart
      @user_cart ||= Cart.new
      flash[:notice] = "You dont have any products in your cart."
    end
  end
end
