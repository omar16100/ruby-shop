class CategoriesController < ApplicationController
  before_filter :authenticate_user!, :only => [:show]
  
  # GET /categories
  def index
    @categories = Category.all

    respond_to do |format|
      format.html
      format.json { render json: @categories }
    end
  end

  # GET /categories/1
  def show
    @products = Category.find(params[:id]).products.page(params[:page]).per(8)

    respond_to do |format|
      format.html
      format.json { render json: @category }
    end
  end
end
