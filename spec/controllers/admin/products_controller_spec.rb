# spec/controllers/admin/products_controller_spec.rb

require 'spec_helper'

describe Admin::ProductsController do

  # == signed admin user ==
  context "signed admin user" do
    before :each do
      @user = create(:admin_user)
      sign_in @user
    end

    # == index ==
    describe "load all existing products" do
      it "should render index view and load all existing products" do
        products = [create(:product), create(:product)]
        get :index

        assigns(:admin_products).should == products
        response.should render_template :index
      end
    end

    # == show ==
    describe "show product details" do
      it "should retrieve product info and render :show view" do
        product = create(:product)
        get :show, id: product

        assigns(:admin_product).should be_eql product
        response.should render_template :show
      end
    end

    # == new, create ==
    describe "add a new product" do
      before :each do
          @category = create(:category)
        end

      it "should load :new product view" do
        get :new
        response.should render_template :new
      end

      context "add product with valid data" do
        it "should create a new product" do
          expect {
            post :create, product: attributes_for(:product, category_id: @category.id)
          }.to change(Product, :count).by(1)
        end

        it "should retrieve new product and redirect :show view" do
          post :create, product: attributes_for(:product, category_id: @category.id)

          assigns(:admin_product).should be_eql Product.last
          response.should redirect_to admin_product_path Product.last
        end
      end

      context "add product with invalid data" do
        it "should re-render :new view with founded errors" do
          post :create, product: attributes_for(:product, name: nil, category_id: @category.id)

          assigns(:admin_product).errors.should_not be_nil
          response.should render_template :new
        end
      end      
    end

    # == edit, update ==
    describe "edit an existing product" do
      before :each do
          @product = create(:product)
          @new_name = "new-edited-product-name"
        end

      it "should load :edit product view" do
        get :edit, id: @product
        response.should render_template :edit
      end

      context "edit existing product with valid data" do
        it "should create a new product" do
          put :update, id: @product, product: attributes_for(:product, name: @new_name)

          @product.reload
          @product.name.should be_eql @new_name
          assigns(:admin_product).errors.count.should be == 0
        end

        it "should retrieve updated product and redirect :show view" do
          put :update, id: @product, product: attributes_for(:product, name: @new_name)

          @product.reload
          assigns(:admin_product).should be_eql @product
          response.should redirect_to admin_product_path(@product)
        end
      end

      context "add product with invalid data" do
        it "should re-render :edit view with founded errors" do
          put :update, id: @product, product: attributes_for(:product, name: nil)

          assigns(:admin_product).errors.any?.should be_true
          response.should render_template :edit
        end
      end      
    end

    # == destroy ==
    describe "delete an existing product" do
      it "should delete the product and redirect to index view" do
        product = create(:product)
        
        expect {
          delete :destroy, id: product
          }.to change(Product, :count).by(-1)
        response.should redirect_to admin_products_path
      end
    end

  end
  #end-of signed admin user
end