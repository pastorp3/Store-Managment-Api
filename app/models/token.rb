class Token < ApplicationRecord
	belongs_to :user
	has_many :user_dbs, through: :user
	has_many :products, through: :user_dbs
	has_many :orders , through: :user_dbs
end
