class Post < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  validates :entry, presence: true
  validates :title, presence: true
  validates :group_id, presence: true
end
