class ApplicationController < ActionController::Base
  protect_from_forgery
  #check_authorization :unless => :devise_controller?

  before_filter :load_commons

  layout :layout_by_resource

  protected

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => "You're not allowed to do this action."
  end

  private 

  def load_commons
    @cart = current_user && current_user.cart ? current_user.cart : Cart.new
    @categories = Category.all
  end

  def layout_by_resource
    if devise_controller?
      "login"
    else
      "application"
    end
  end

end