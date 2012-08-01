
require 'spec_helper'

describe User do
  it "should have a valid factory" do
    create(:user).should be_valid
  end

  it "should retrieve full name" do
    user = create(:user, first_name: "Jhon", last_name: "Doe")
    user.full_name.should be_eql "Jhon Doe"
  end
end