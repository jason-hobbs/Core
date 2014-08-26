class Reply < ActiveRecord::Base
  validates_length_of :entry, :in => 2..10000, :allow_blank => false
  belongs_to :post
  belongs_to :user
end
