# spec/controllers/products_controller_spec.rb

require "spec_helper"

describe ProductsController do
  
  context "guest user" do
    before :each do
      @product = create(:product)
    end

    describe "GET index" do
      it "should retrieve a list of @products" do
        get :index
        assigns(:products).should include(@product)
      end

      it "should retrieve a list of @categories" do
        create(:category)
        get :index
        assigns(:categories).count.should be_eql 2
      end

      it "should render the index view" do
        get :index
        response.should render_template :index
      end
    end

    describe "GET show" do
      it "should redirect the sign-in page" do
        get :show, id: @product
        response.should redirect_to new_user_session_path
      end
    end
  end

  context "authorized user" do
    before :each do
      @user = create(:user)
      sign_in @user
    end

    describe "GET show" do
      before :each do
        @product = create(:product)
        get :show, id: @product
      end

      it "should render the show view" do
        response.should render_template :show
      end

      it "should retrieve a list of categories" do
        assigns(:categories).should be_eql [@product.category]
      end

      it "shoudl retrieve the selected product info" do
        assigns(:product).should be_eql @product
      end
    end
  end

  context "searching products" do
    before :each do
      @tennis = create(:product, name: "tennis")
      @book = create(:product, name: "book")
    end

    it "should retrieve all categories" do
      category = create(:category)
      post :search
      assigns(:categories).should include category
    end

    describe "looking for existing product with 'tennis' keyword" do
      it "should retrieve product info" do
        post :search, name: "tennis"
        assigns(:products).should == [@tennis]
      end

      it "should render the index view" do
        post :search, name: "tennis"
        response.should render_template :index
      end
    end

    describe "looking for non existint product with 'shoes' keyword" do
      it "should not retrieve any products" do
        post :search, name: "shoes"
        assigns(:products).count.should be_eql(0)
      end

      it "should show a notice message" do
        post :search, name: "shoes"
        flash[:notice].should =~ /No product name matched/
      end
      
      it "should render the index view" do
        post :search, name: "shoes"
        assigns(:products).count.should be_eql(0)
      end
    end
  end

end