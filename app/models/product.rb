class Product < ApplicationRecord
	belongs_to :user_db
	has_many :orders
end
