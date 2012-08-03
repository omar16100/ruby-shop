# spec/controllers/admin_controller_spec.rb

require 'spec_helper'

describe AdminController do

  describe "get #index" do
  
    context "guest user" do
      it "should render index page and retrieve error" do
        get :index
        response.should redirect_to root_path
        flash[:alert].should_not be_nil
      end
    end

    context "signed in user" do
      it "should render home page and retrieve error" do
        user = create(:user)
        sign_in user

        get :index
        response.should redirect_to root_path
        flash[:alert].should_not be_nil
      end
    end

    context "signed in admin user" do
      it "should render admin index view" do
        user = create(:admin_user)
        sign_in user
        
        get :index
        response.should render_template :index
      end
    end

  end

end