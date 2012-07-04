class Product < ActiveRecord::Base
  attr_accessible :description, :name, :on_sale, :price, :qty, :sale_price, :category
  belongs_to :category

  validates :name, :price, :qty, :presence => true
  validates :price, :sale_price, :qty, :numericality => true
end
