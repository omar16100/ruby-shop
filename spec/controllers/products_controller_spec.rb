# spec/controllers/products_controller_spec.rb

require "spec_helper"

describe ProductsController do
  
  context "guest user" do
    describe "GET index" do
      it "should render the index view"
      it "should retrieve a list of @products"
      it "should retrieve a list of @categories"
    end

    describe "GET show" do
      it "should redirect the sign-in page"
    end
  end

  context "authorized user" do
    describe "GET index" do
      it "should render the index view"
      it "should retrieve a list of @products"
      it "should retrieve a list of @categories"
    end

    describe "GET show" do
      it "should render the show view"
      it "should retrieve a list of categories"
      it "shoudl retrieve the selected product info"
    end
  end

  context "searching products" do
    describe "looking for existint product by 'tennis' keyword" do
      it "shoudl retrieve product info"
      it "should render the index view"
    end

    describe "looking for non existint product by 'perin' keyword" do
      it "shoudl show a notice message"
      it "should render the index view"
    end
  end

end