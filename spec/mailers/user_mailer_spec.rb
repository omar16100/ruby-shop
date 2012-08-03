# spec/mailers/user_mailer_spec.rb

require 'spec_helper'

describe UserMailer do

  describe "product price changed" do

    it "should send a email to the user" do
      email = "testuser@test.com"
      user = create(:user, email: email)
      product = create(:product, name: "test product")

      mail = UserMailer.price_changed(user, product)

      mail.to.should == [ email ]
      mail.subject.should match(/#{product.name}/)
    end
  end

end