# spec/models/product_observer_spec.rb

require 'spec_helper'

describe ProductObserver do
  it "should send mail when product price changed" do
    cart = create(:cart)
    mailer = mock(UserMailer)

    product = create(:product)
    cart.products << product
    cart.products.count.should be > 0

    UserMailer.stub(:price_changed).with(cart.user, product).and_return(mailer)
    UserMailer.should_receive(:price_changed)
    mailer.should_receive(:deliver)

    product.price += 100
    product.save
  end

end
