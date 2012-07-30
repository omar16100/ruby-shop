class Admin::UsersController < ApplicationController
  
  layout "backend"

  # GET /admin/users
  def index
    @admin_users = User.all

    respond_to do |format|
      format.html
      format.json { render json: @admin_users }
    end
  end

  # GET /admin/users/1
  def show
    @admin_user = User.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @admin_user }
    end
  end

  # GET /admin/users/new
  def new
    @admin_user = User.new

    respond_to do |format|
      format.html
      format.json { render json: @admin_user }
    end
  end

  # GET /admin/users/1/edit
  def edit
    @admin_user = User.find(params[:id])
  end

  # POST /admin/users
  def create
    @admin_user = User.new(params[:user])

    respond_to do |format|
      if @admin_user.save
        format.html { redirect_to admin_user_path(@admin_user), notice: 'User was successfully created.' }
        format.json { render json: @admin_user, status: :created, location: @admin_user }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/users/1
  def update
    updated_user = params[:user]
    @admin_user = User.find(params[:id])

    respond_to do |format|
      if @admin_user.update_attributes(params[:user])
        format.html { redirect_to admin_user_path(@admin_user), notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1
  def destroy
    @admin_user = User.find(params[:id])
    @admin_user.destroy

    respond_to do |format|
      format.html { redirect_to admin_users_path }
      format.json { head :no_content }
    end
  end
end
