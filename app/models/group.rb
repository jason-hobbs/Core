class Group < ActiveRecord::Base
  belongs_to :user
  has_many :posts
  has_many :groupmembers, dependent: :destroy
  has_many :users, through: :groupmembers
end
