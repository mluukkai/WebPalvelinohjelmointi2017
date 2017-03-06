class BeerClub < ActiveRecord::Base
  #has_many :memberships, dependent: :destroy
  has_many :memberships, -> { where confirmed: true }, dependent: :destroy
  has_many :applications, -> { where confirmed: [nil, false] }, class_name: "Membership"
  has_many :members, through: :memberships, source: :user
  has_many :applicants, through: :applications, source: :user
end