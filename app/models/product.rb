class Product < ActiveRecord::Base
  extend FriendlyId

  friendly_id :name, use: :slugged

  attr_accessible :description, :name, :on_sale, :price, :qty, :sale_price, :category, :category_id
  belongs_to :category

  has_attached_file :photo, styles: { thumb: "150x150>", normal: "400x400>" }

  scope :in_stock, where("qty > 0")
  scope :by_category, lambda { |id| where(category_id: id) }

  validates :name, :price, :qty, :presence => true
  validates :price, :sale_price, :qty, :numericality => true
  validates :category, :presence => true
  
  validates_attachment :photo,
    content_type: { content_type: /^image\/.?(gif|png|jpg|jpeg)$/i },
    size: { in: 0..2000.kilobytes }

  def current_price
    on_sale ? sale_price : price
  end
end
