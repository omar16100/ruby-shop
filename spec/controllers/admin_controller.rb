# spec/controllers/admin_controller_spec.#!/usr/bin/env ruby -wKU

describe AdminController do

  describe "get #index" do
  
    context "guest user" do
      it "should render sign-in page"
      it "should display an error message"
    end

    context "signed in user" do
      it "should render home page"
      it "should display an information message"
    end

    context "signed in admin user" do
      it "should render admin index view"
    end

  end

end