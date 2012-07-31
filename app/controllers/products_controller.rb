class ProductsController < ApplicationController
  before_filter :authenticate_user!, :only => [:show]
  
  # GET /products
  def index
    @categories = get_all_categories
    @products = Product.in_stock.page(params[:page]).per(9)

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

  def search
    search = Product.search do
      fulltext params[:name]
    end

    @categories = get_all_categories
    @products = search.results
    flash[:notice] = "No product name matched the keywords." unless @products.any?

    render :index
  end

  private
    def get_all_categories
      Category.all
    end
end
