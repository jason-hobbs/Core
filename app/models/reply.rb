class Reply < ActiveRecord::Base
  validates :entry, presence: true
  belongs_to :post
  belongs_to :user
end
