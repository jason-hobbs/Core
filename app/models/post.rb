class Post < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  belongs_to :tag
  has_many :replies
  validates :entry, presence: true
  validates :title, presence: true
  validates :group_id, presence: true
  validates :tag_id, presence: true
  validates :user_id, presence: true
end
