# spec/controllers/categories_controller_spec.rb

require "spec_helper"

describe CategoriesController do
  
  context "gest user" do

    describe "GET index" do
      it "should render the index view"
      it "should retrieve a list of @categories"
    end

    describe "GET show" do
      it "should redirect to sign-in page"
    end

  end

  context "authorized user" do

    describe "GET index" do
      it "should render the index view"
      it "should retrieve a list of @categories"
    end

    describe "GET show" do
      it "should render the show view"
      it "should retrieve the selected @category"
      it "should retrieve a list of @producs according to category"
      it "should not retrieve producs from another category"
    end

  end

end