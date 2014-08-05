class Group < ActiveRecord::Base
  belongs_to :user
  has_many :posts, dependent: :destroy
  has_many :groupmembers, dependent: :destroy
  has_many :users, through: :groupmembers
end
