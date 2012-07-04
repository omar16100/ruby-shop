class Category < ActiveRecord::Base
  attr_accessible :color, :name
  has_many :products

  validate :name, :presence => true
end
