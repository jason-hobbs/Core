class Tag < ActiveRecord::Base
  has_many :posts
  validates :name, presence: true
  validates :color, presence: true
  validates :textcolor, presence: true
end
