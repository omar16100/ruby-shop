class Admin::ProductsController < ApplicationController
  
  layout "backend"

  # GET /admin/products
  def index
    @admin_products = Product.page params[:page]

    respond_to do |format|
      format.html
      format.json { render json: @admin_products }
    end
  end

  # GET /admin/products/1
  def show
    @admin_product = Product.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @admin_product }
    end
  end

  # GET /admin/products/new
  def new
    @admin_product = Product.new
    @categories = get_category_list

    respond_to do |format|
      format.html
      format.json { render json: @admin_product }
    end
  end

  # GET /admin/products/1/edit
  def edit
    @admin_product = Product.find(params[:id])
    @categories = get_category_list
  end

  # POST /admin/products
  def create
    @admin_product = Product.new(params[:product])

    respond_to do |format|
      if @admin_product.save
        format.html { redirect_to admin_product_path(@admin_product), notice: 'Product was successfully created.' }
        format.json { render json: @admin_product, status: :created, location: @admin_product }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/products/1
  def update
    @admin_product = Product.find(params[:id])

    respond_to do |format|
      if @admin_product.update_attributes(params[:product])
        format.html { redirect_to admin_product_path(@admin_product), notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/products/1
  def destroy
    @admin_product = Product.find(params[:id])
    @admin_product.destroy

    respond_to do |format|
      format.html { redirect_to admin_products_url }
      format.json { head :no_content }
    end
  end

  private
    def get_category_list
      Category.all.collect { |cat| [cat.name, cat.id] }
    end
end
