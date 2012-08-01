class Category < ActiveRecord::Base
  extend FriendlyId

  friendly_id :name, use: :slugged

  attr_accessible :color, :name
  has_many :products

  validates :name, :presence => true
end
