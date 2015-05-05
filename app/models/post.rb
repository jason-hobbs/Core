class Post < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  belongs_to :tag
  has_many :replies, dependent: :destroy
  validates :title, presence: true, uniqueness: true
  validates :group_id, presence: true
  validates :tag_id, presence: true
  validates :user_id, presence: true
  validates_length_of :entry, :in => 2..10000, :allow_blank => false

  include PgSearch
  pg_search_scope :search, against: [:title, :entry],
  using: {tsearch: {dictionary: "english"}},
  associated_against: {replies: :entry}

  def self.text_search(query)
    if query.present?
      search(query)
    else
      order("created_at DESC")
    end
  end
end
