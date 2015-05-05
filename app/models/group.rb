class Group < ActiveRecord::Base
  belongs_to :user
  has_many :posts, dependent: :destroy
  has_many :groupmembers, dependent: :destroy
  has_many :users, through: :groupmembers
  validates :name, presence: true

  before_save :generate_slug

  def to_param
    self.slug
  end

  def generate_slug
    self.slug ||= name.parameterize if name
  end


end
