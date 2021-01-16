class Token < ApplicationRecord
	belongs_to :user
	has_many :user_dbs, through: :user
end
