class Beer < ActiveRecord::Base
  include RatingAverage
  
  belongs_to :brewery
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { uniq }, through: :ratings, source: :user

  validates :name, presence: true
  validates :style, presence: true

  def to_s
    "#{name} #{brewery.name}"
  end

  def average
    binding.pry
    ratings.map{ |r| r.score }.sum / ratings.count.to_f
  end
end