# spec/controllers/admin/categories_controller_spec.rb

require 'spec_helper'

describe Admin::CategoriesController do
  
  context "signed admin user" do
    before :each do
      @user = create(:admin_user)
      sign_in @user
    end

    describe "list all existing categories - get index" do
      it "should retrieve a list of @categories" do
        category = create(:category)
        
        get :index
        assigns(:categories).should == [ category ]
      end

      it "should render the index view" do
        get :index
        response.should render_template :index
      end
    end

    describe "load new category feature - get new" do
      it "should render new view" do
        get :new
        response.should render_template :new
      end
    end

    describe "create new category - post create" do
      context "creating with valid data" do
        it "should create a new category" do
          expect {
            post :create, category: attributes_for(:category)
          }.to change(Category, :count).by(1)
        end

        it "should retrieve the created category" do
          post :create, category: attributes_for(:category)
          assigns(:admin_category).should_not be_nil
        end

        it "should redirect show view" do
          post :create, category: attributes_for(:category)
          response.should redirect_to admin_category_path(Category.last)
        end

        it "should display a sucess message" do
          post :create, category: attributes_for(:category)
          flash[:notice] =~ /sucessfully created/
        end
      end

      context "creating with invalid data" do
        before :each do
          post :create, category: attributes_for(:category, name: nil)
        end

        it "should re-render the new view" do
          response.should render_template :new
        end

        it "should retrieve error messaged" do
          assigns(:admin_category).errors.should_not be_nil
        end
      end
    end

  end

end