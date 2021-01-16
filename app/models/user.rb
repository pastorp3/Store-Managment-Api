class User < ApplicationRecord
	validates :username, presence: true
	validates_uniqueness_of :username
	validates :email, presence: true
	validates_uniqueness_of :email
		validates :password, presence: true 
end
