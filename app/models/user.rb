class User < ActiveRecord::Base
  has_secure_password
  has_many :reviews
  has_many :restrooms, through: :reviews

  def slug
    self.username.split(" ").join("-").downcase
  end

  def self.findby_slug(slug)
    self.all.detect{|user| user.slug == slug}
  end

end
