class User < ActiveRecord::Base

  has_one :cart, dependent: :destroy

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :admin, :photo
  # attr_accessible :title, :body

  has_attached_file :photo

  validates_attachment :photo,
    content_type: { content_type: /^image\/.?(gif|png|jpg|jpeg)$/i },
    size: { in: 0..500.kilobytes }

end
