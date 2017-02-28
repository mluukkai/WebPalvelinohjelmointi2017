class Style < ActiveRecord::Base
  include RatingAverage
  
  has_many :beers
  has_many :ratings, through: :beers

  def to_s
    name
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Style.all.sort_by{ |b| -(b.average_rating||0) }[0,n]
  end    
end