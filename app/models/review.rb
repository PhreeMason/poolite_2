class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :restroom

  def old_restroom=(restroom)
    if !restroom.empty?
      self.restroom = Restroom.find_by(restaurant_name: restroom)
      self.save
    end
  end

  def restroom_hash=(hash)
    if hash.values.none? {|a| a.empty?}
      self.build_restroom(hash)
      self.save
    end
  end

  def show_stars
    if self.stars == 1
      return "#{self.stars} Star"
    else
      return "#{self.stars} Stars"
    end
  end
end
