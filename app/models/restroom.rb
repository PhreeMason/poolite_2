class Restroom < ActiveRecord::Base
  has_many :reviews
  has_many :users, through: :reviews

  def show_stars
    if !self.reviews.empty?
      (self.reviews.map(&:stars).map(&:to_f).reduce(:+)/self.reviews.all.count).round(1)
    else
      return 0
    end
  end
  def rating
    if self.show_stars == 1
      return "#{self.show_stars} Star"
    else
      return "#{self.show_stars} Stars"
    end
  end
end
