class Post < ActiveRecord::Base
  belongs_to :group
  validates :entry, presence: true
  validates :title, presence: true
  validates :group_id, presence: true
end
