require'spec_helper'

describe Category do
  context "base" do
    it "has a valid FactoryGirl" do
      cat = build(:category)
      cat.should be_valid
    end
  end

  context "validations" do
    before(:all) do 
      @cat = build(:category)
    end

    it "should validate ausence of name" do
      @cat.name = nil
      @cat.should_not be_valid
      @cat.errors[:name].should_not be_nil
    end

    it "should validate presence of name" do
      @cat.name = "just a name"
      @cat.should be_valid
    end
  end
end
