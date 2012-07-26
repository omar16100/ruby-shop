class Product < ActiveRecord::Base
  extend FriendlyId

  friendly_id :name, use: :slugged

  attr_accessible :description, :name, :on_sale, :price, :qty, :sale_price, :category, :category_id
  belongs_to :category

  validates :name, :price, :qty, :presence => true
  validates :price, :sale_price, :qty, :numericality => true
  validates :category, :presence => true

  scope :in_stock, where("qty > 0")
  scope :by_category, lambda { |id| where(category_id: id) }

  def current_price
    on_sale ? sale_price : price
  end
end
