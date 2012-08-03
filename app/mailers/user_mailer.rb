class UserMailer < ActionMailer::Base
  default from: "admin@rubyshop.com"

  def product_added_to_cart(user, product)
    @user = user
    @product = product
    mail(:to => user.email, :subject => "#{product.name} was added to your cart.")
  end

  def price_changed(user, product)
    @user = user
    @product = product
    mail(:to => user.email, :subject => "The price of #{product.name} has changed.")
  end
end
