require'spec_helper'

describe Product do
  context "base" do
    it "has a valid FactoryGirl" do
      product = build(:product)
      product.should be_valid
    end
  end

  context "validations" do
    before(:all) do 
      @product = build(:product)
    end

    it "should validate presence of name" do
      @product.name = nil
      @product.should_not be_valid
      @product.errors[:name].should_not be_nil
    end

    it "should validate presence of price" do
      @product.price = nil
      @product.should_not be_valid
      @product.errors[:price].should_not be_nil
    end

    it "should validate presence of category" do
      @product = build(:product, category: nil)
      @product.should_not be_valid
      @product.errors[:category].should_not be_nil
    end
    
    it "should validate presence of qty" do
      @product.qty = nil
      @product.should_not be_valid
      @product.errors[:qty].should_not be_nil
    end

    it "should validate numericality of price" do
      @product.price = 'abc'
      @product.should_not be_valid
      @product.errors[:price].should_not be_nil
    end
    it "should validate numericality of sale_price" do
      @product.sale_price = 'abc'
      @product.should_not be_valid
      @product.errors[:sale_price].should_not be_nil
    end
    it "should validate numericality of qty" do
      @product.qty = 'abc'
      @product.should_not be_valid
      @product.errors[:qty].should_not be_nil
    end
  end

  describe "scopes" do
    it "in_stock should return items in stock" do
      @in_stock = create(:product, qty: 5)
      @out_of_stock = create(:product, qty: 0)
      result = Product.in_stock
      result.should include(@in_stock)
      result.should_not include(@out_of_stock)
    end

    it "by_category should return category items" do
      @cat1 = create(:category)  
      @cat2 = create(:category)  
      product1 = create(:product, category: @cat1)
      product2 = create(:product, category: @cat2)

      result = Product.by_category(@cat1.id)
      result.should include(product1)
      result.should_not include(product2)
    end
  end

  it "current_price should return sale_price if object is on sale, otherwise - price" do
    product = create(:product, on_sale: false, price: 100, sale_price: 55)
    product.current_price.should == 100
    product.on_sale = true
    product.current_price.should == 55
  end
end