class Post < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  belongs_to :tag
  has_many :replies
  validates :title, presence: true
  validates :group_id, presence: true
  validates :tag_id, presence: true
  validates :user_id, presence: true
  validates_length_of :entry, :in => 2..10000, :allow_blank => false
end
