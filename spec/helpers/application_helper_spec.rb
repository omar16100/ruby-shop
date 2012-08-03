# spec/helpers/application_helper_spec.rb

require 'spec_helper'

require_relative "../../app/helpers/application_helper"
include ApplicationHelper

describe ApplicationHelper do

  context "guest user" do
    it "should show only general options" do
      ApplicationHelper.stub(:somebody_signed_in?).and_return(false)

      ApplicationHelper.get_menu_options.should be_eql ["Products", "Categories", "Github"]
    end
  end

  context "authenticated user" do
    it "should show general options and profile" do
      ApplicationHelper.stub(:somebody_signed_in?).and_return(true)
      ApplicationHelper.stub(:the_user_is_admin?).and_return(false)

      ApplicationHelper.get_menu_options.should be_eql ["Products", "Categories", "Profile", "Github"]
    end
  end

  context "authenticated admin" do
    it "should show general options and profile" do
      ApplicationHelper.stub(:somebody_signed_in?).and_return(true)
      ApplicationHelper.stub(:the_user_is_admin?).and_return(true)

      ApplicationHelper.get_menu_options.should be_eql ["Products", "Categories", "Profile", "Admin", "Github"]
    end
  end
end