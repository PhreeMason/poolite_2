class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :restroom

  def average
    self.reviews.collect { review.star }.reduce(:+)
  end

end
