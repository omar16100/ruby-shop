class ProductsController < ApplicationController
  before_filter :authenticate_user!, :only => [:show]
  
  # GET /products
  def index
    @products = Product.in_stock.page(params[:page]).per(8)

    respond_to do |format|
      format.html
      format.json { render json: @products }
    end
  end

  # GET /products/1
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @product }
    end
  end
end
