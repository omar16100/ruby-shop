class CartController < ApplicationController
  
  # authorize_resource

  # GET /cart
  def index
    @user_cart = get_current_user_cart

    unless @user_cart.products.any?
      flash[:notice] = "You dont have any products in your cart."
    end
  end

  # edit cart, adding products
  def edit
    @user_cart = get_current_user_cart

    added_product = Product.find(params[:id])
    @user_cart.products << added_product

    UserMailer.product_added_to_cart(@user_cart.user, added_product).deliver
    
    redirect_to cart_index_path, notice: 'Product was added to the cart.'
  end

  def destroy
      @user_cart = get_current_user_cart
      
      product = Product.find params[:id]
      products = CartItem.where(cart_id: @user_cart.id, product_id: product.id)
      products.first.delete

      redirect_to cart_index_path, notice: 'Product was removed.'
  end

  def empty
      @user_cart = Cart.find params[:cart_id]
      
      @user_cart.products.delete_all

      redirect_to cart_index_path, notice: 'All products were removed.'
  end

  private
    def get_current_user_cart
      Cart.find_by_user_id current_user.id
    end
end
