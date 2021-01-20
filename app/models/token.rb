class Token < ApplicationRecord
	belongs_to :user
	has_many :user_dbs, through: :user
	has_many :products, through: :user_dbs
	has_many :orders , through: :user_dbs

	def self.user_products token
		token.products
	end

	def self.user_orders token
		token.orders
	end

	def self.user_dbs token
		token.user_dbs
	end

	def self.get_user_db_id token
		token.user_dbs.ids.first
	end
end
