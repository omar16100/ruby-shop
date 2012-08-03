# spec/controllers/users_controller_spec.rb

require 'spec_helper'

describe Admin::UsersController do

  # == signed admin user ==
  context "signed admin user" do
    before :each do
      @user = create(:admin_user)
      sign_in @user
    end

    # == index, show ==
    describe "show all existing users" do
      it "should render index view with a list existing users" do
        get :index

        assigns(:admin_users).should == [@user]
        response.should render_template :index
      end

      it "should show detail info from particular user" do
        get :show, id: @user

        assigns(:admin_user).should be_eql @user
        response.should render_template :show
      end
    end

    # == new, create ==
    describe "add new users to database" do
      it "should render :new view to add data" do
        get :new
        response.should render_template :new
      end

      context "add new user with valid data" do
        it "should create the new user" do
          expect {
            post :create, user: attributes_for(:user)
          }.to change(User, :count).by(1)
        end

        it "should retrieve created user and render :show view" do
          post :create, user: attributes_for(:user)

          assigns(:admin_user).should be_eql User.last
          response.should redirect_to admin_user_path(User.last)
        end
      end

      context "add new user with invalid data" do
        it "should re-render :new view and retrieve founded errors" do
          post :create, user: attributes_for(:user, email: nil)

          assigns(:admin_user).errors.any?.should be_true
          response.should render_template :new
        end
      end
    end

    # == edit, update ==
    describe "edit an existing user" do
      it "should show :edit view and retrieve user info" do
        get :edit, id: @user
        assigns(:admin_user).should be_eql @user
        response.should render_template :edit
      end

      context "update user info with valid data" do
        it "should update data in database" do
          put :update, id: @user, user: attributes_for(:user, first_name: "updated-name")
          @user.reload
          @user.first_name.should be_eql "updated-name"
        end

        it "should retrieve updated info and render :show view" do
          put :update, id: @user, user: attributes_for(:user)
          assigns(:admin_user).should be_eql @user
        end
      end

      context "update user info with invalid data" do
        it "should re-render :edit view and retrieve errors founded" do
          put :update, id: @user, user: attributes_for(:user, email: nil)
          assigns(:admin_user).errors.any?.should be_true
          response.should render_template :edit
        end
      end
    end

    # == destroy ==
    describe "delete and existing user" do
      it "should delete user from db and redirect to :index view" do
        expect {
          delete :destroy, id: @user
          }.to change(User, :count).by(-1)
          response.should redirect_to admin_users_path
      end
    end

  end
end