class CartController < ApplicationController
  
  authorize_resource

  # GET /cart
  def index
    @user_cart = get_current_user_cart

    unless @user_cart.products.any?
      flash[:notice] = "You dont have any products in your cart."
    end
  end

  # add one product
  def edit
    @user_cart = get_current_user_cart

    added_product = Product.find(params[:id])
    @user_cart.products << added_product

    UserMailer.product_added_to_cart(@user_cart.user, added_product).deliver
    
    redirect_to cart_index_path, notice: 'Product was added to the cart.'
  end

  # remove one product
  def update
      @user_cart = get_current_user_cart
      
      product = Product.find params[:id]
      @user_cart.products.delete product
      #products = CartItem.where(cart_id: @user_cart.id, product_id: params[:id])
      #products.first.delete

      redirect_to cart_index_path, notice: 'Product was removed.'
  end

  # remove all products
  def destroy
      @user_cart = Cart.find params[:id]
      
      @user_cart.products.delete_all

      redirect_to cart_index_path, notice: 'All products were removed.'
  end

  private
    def get_current_user_cart
      Cart.find_by_user_id current_user.id
    end
end
