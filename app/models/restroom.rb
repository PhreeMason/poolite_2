class Restroom < ActiveRecord::Base
  has_many :reviews
  has_many :users, through: :reviews

  def rating
    self.reviews.map(&:stars).map(&:to_f).reduce(:+)/self.reviews.all.count
  end

end
