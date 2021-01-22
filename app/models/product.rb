class Product < ApplicationRecord
	belongs_to :user_db
	has_many :orders
	validates :name, presence: true
	validates :stock, presence: true
	validates :price, presence: true
end
