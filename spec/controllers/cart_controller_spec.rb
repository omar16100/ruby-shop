# spec/controllers/cart_controller_spec.rb

require 'spec_helper'

describe CartController do
  
  context "signed in user" do
    before :each do
      @cart = create(:cart)
      sign_in @cart.user
    end

    # == index ==
    describe "show my cart info" do
      it "should retrieve my cart and products" do
        get :index
        assigns(:user_cart).should_not be_nil
        response.should render_template :index
      end

      it "should list all my products if any" do
        @cart.products << build(:product)
        get :index
        assigns(:user_cart).products.any?.should_not be_nil
      end
    end

    # == edit ==
    describe "adding items to cart" do
      before :each do
        @product = create(:product)
      end

      it "should add the new product to my cart" do
        expect {
          get :edit, id: @product
        }.to change(CartItem, :count).by(1)

        assigns(:user_cart).products.any?.should be_true
        response.should redirect_to cart_index_path
      end

      it "should send me an email about the new product" do
        mailer = mock(UserMailer)
        UserMailer.stub(:product_added_to_cart).with(@cart.user, @product).and_return(mailer)

        UserMailer.should_receive(:product_added_to_cart)
        mailer.should_receive(:deliver)

        get :edit, id: @product
      end
    end

    # == update, destroy ==
    describe "removing products from cart" do
      before :each do
        @product = create(:product)
        @cart.products << @product
      end

      it "should allow to remove all products in my cart" do
        @cart.products.any?.should be_true

        delete :destroy, id: @cart

        assigns(:user_cart).products.any?.should be_false
      end

      it "should allow to remove one product from my cart" do
        @cart.products.count.should be > 0
        initial_count = @cart.products.count

        put :update, id: @product

        assigns(:user_cart).products.count.should be < initial_count
        response.should redirect_to cart_index_path
      end
    end

  end

end