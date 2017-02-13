module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    ratings.map(&:score).inject(&:+)/ratings.count.to_f 
  end  
end