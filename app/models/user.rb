class User < ActiveRecord::Base

  has_one :cart, dependent: :destroy

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :admin, :photo, :first_name, :last_name, :birthday, :country
  # attr_accessible :title, :body

  has_attached_file :photo, styles: { thumb: "150x150>", mini: "40x40>" }

  validates_attachment :photo,
    content_type: { content_type: /^image\/.?(gif|png|jpg|jpeg)$/i },
    size: { in: 0..500.kilobytes }

  validates :email, :presence => true

  def full_name
    [self.first_name, self.last_name].join(' ')
  end

end
