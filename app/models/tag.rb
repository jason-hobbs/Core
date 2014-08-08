class Tag < ActiveRecord::Base
  has_many :posts
  validates :name, presence: true
  validates :class, presence: true
end
