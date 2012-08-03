class UserMailer < ActionMailer::Base
  default from: "admin@rubyshop.com"

  def product_added_to_cart(user, product)
    @user = user
    @product = product
    mail(:to => user.email, :subject => "Product added to your cart.")
  end

  def price_changed(user, product)
    @user = user
    @product = product
    mail(:to => user.email, :subject => "Product price has changed.")
  end
end
