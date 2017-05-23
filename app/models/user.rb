class User < ActiveRecord::Base
  has_secure_password
  has_many :reviews
  has_many :restrooms, through: :reviews
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true

  def slug
    self.username.split(" ").join("-").downcase
  end

  def self.findby_slug(slug)
    self.all.detect{|user| user.slug == slug}
  end

end
