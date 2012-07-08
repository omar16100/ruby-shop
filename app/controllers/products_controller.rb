class ProductsController < ApplicationController
  before_filter :authenticate_user!, :only => [:show]
  
  # GET /products
  def index
    @products = if params.has_key? "category_id"
      Product.in_stock.by_category params[:category_id]
    else
      Product.in_stock
    end

    @category_name = @products.first.category.name

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
