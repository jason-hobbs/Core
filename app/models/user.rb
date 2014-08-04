class User < ActiveRecord::Base
  has_secure_password
  has_many :posts
  has_many :replies
  has_many :groupmembers, dependent: :destroy
  has_many :groups, through: :groupmembers
  validates :name, presence: true
  validates :email, presence: true,
                  format: /\A\S+@\S+\z/,
                  uniqueness: { case_sensitive: false }
  def gravatar_id
  	Digest::MD5::hexdigest(email.downcase)
  end

  def self.authenticate(email, password)
  	user = User.find_by(email: email)
  	user && user.authenticate(password)
  end
end
