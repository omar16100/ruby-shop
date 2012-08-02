# spec/controllers/admin/categories_controller_spec.rb

require 'spec_helper'

describe Admin::CategoriesController do
  
  # == signed admin user ==
  context "signed admin user" do
    before :each do
      @user = create(:admin_user)
      sign_in @user
    end

    # == index ==
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

    # == new ==
    describe "load new category feature - get new" do
      it "should render new view" do
        get :new
        response.should render_template :new
      end
    end

    # == show ==
    describe "display detailed info to selected category" do
      before :each do
        @cat = create(:category)
        get :show, id: @cat
      end

      it "should retrieve category info" do
        assigns(:admin_category).should be_eql @cat
      end

      it "should render show view" do
        response.should render_template :show
      end
    end

    # == create ==
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

    # == edit ==
    describe "edit and existing category" do
      before :each do
        @cat = create(:category)
        get :edit, id: @cat
      end

      it "should retrieve info from selected category" do
        assigns(:admin_category).should be_eql @cat
      end

      it "should render the edit view" do
        response.should render_template :edit
      end
    end

    # == update ==
    describe "update data to existing category" do
      before :each do
          @cat = create(:category)
        end

      context "updating category with valid data" do
        before :each do
          put :update, id: @cat, category: attributes_for(:category, name: "new-cat-name")
        end

        it "it should save modified data" do
          @cat.reload
          @cat.name.should be_eql "new-cat-name"
        end

        it "it should retrieve the updated category" do
          assigns(:admin_category).should_not be_nil
        end

        it "should display a sucess message" do
          flash[:notice].should_not be_nil
        end
        
        it "should redirect to show view" do
          @cat.reload
          response.should redirect_to admin_category_path(@cat)
        end
      end

      context "updating category with invalid data" do
        before :each do
          put :update, id: @cat, category: attributes_for(:category, name: nil)
        end

        it "should retrieve founded errors" do
          assigns(:admin_category).errors.should_not be_nil
        end

        it "should re-render the edit view" do
          response.should render_template :edit
        end
      end
    end

    # == destroy ==
    describe "delete a selected category" do
      before :each do
        @cat = create(:category)
      end

      it "should delete category info from db" do
        expect {
          delete :destroy, id: @cat
        }.to change(Category, :count).by(-1)
      end

      it "should redirect to index view" do
        delete :destroy, id: @cat
        response.should redirect_to admin_categories_path
      end
    end

  end
  #end-of signed admin user

end