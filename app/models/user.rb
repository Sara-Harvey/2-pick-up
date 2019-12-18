class User < ActiveRecord::Base
	has_many :items

  validates :email, presence: true
  validates :email, uniqueness: true

	has_secure_password
end
