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

  context "friendly url" do
    it "should generate a friendly url for each category" do
      category = create(:category, name: "toys and games")
      category.to_param.should == "toys-and-games"
    end

    it "should add a counter for categories with same name" do
      cat1 = create(:category, name: "shoes")
      cat2 = create(:category, name: "shoes")
      cat2.to_param.should == cat1.to_param.concat("--2")
    end
  end
end
