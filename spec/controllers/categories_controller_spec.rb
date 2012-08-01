# spec/controllers/categories_controller_spec.rb

require "spec_helper"

describe CategoriesController do
  
  context "guest user" do

    describe "GET index" do
      it "should retrieve a list of @categories" do
        category = create(:category)

        get :index
        assigns(:categories).should eql [category]
      end

      it "should render the index view" do
        get :index
        response.should render_template :index
      end
    end

    describe "GET show" do
      before :each do
        @category = create(:category)
        get :show, id: @category
      end

      it "should not render the index view" do
        response.should_not render_template :show  
      end

      it "should redirect to sign-in page" do
        response.should redirect_to new_user_session_path
      end
    end

  end

  context "authorized user" do
    before :each do
      @categories = [create(:category), create(:category)]
      @user = create(:user)
      sign_in @user
    end

    describe "GET index" do
      it "should render the index view" do
        get :index
        response.should render_template :index
      end
      it "should retrieve a list of @categories" do
        get :index
        assigns(:categories).should eql @categories
      end
    end

    describe "GET show" do
      before :each do
        @cat = create(:category_with_products)
        get :show, id: @cat
      end

      it "should retrieve the selected @category" do
        assigns(:category).should eql @cat
      end

      it "should retrieve always @producs in stock" do
        product_without_qty = create(:product, qty: 0)
        @cat.products << product_without_qty

        assigns(:products).should_not include(product_without_qty)
      end

      it "should retrieve a list of @producs according to category" do
        assigns(:products).to_a.should =~ @cat.products.to_a
      end

      it "should not retrieve producs from another category" do
        create(:category_with_products)
        assigns(:products).count.should == 1
      end

      it "should render the show view" do
        response.should render_template :show
      end
    end

  end

end