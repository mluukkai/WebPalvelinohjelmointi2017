class Brewery < ActiveRecord::Base
  include RatingAverage
  
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  scope :active, -> { where active:true }
  scope :retired, -> { where active:[nil,false] }

  validates :name, presence: true
  validates :year, numericality: { greater_than_or_equal_to: 1042,
                                    less_than_or_equal_to: Proc.new{ Time.now.year } ,
                                    only_integer: true }  

  def self.top(n)
    sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -(b.average_rating||0) }[0,n]
  end                                    
end