class UserdbsRepresenter < Api::V1::UserdbsController 
	def initialize(dbs)
		@dbs = dbs
	end

	def as_json
		dbs.map do |db|
			{
				name: db.name,
				products: db.products.count,
				orders: db.orders.count
			}
		end
	end

	private

	attr_reader :dbs


end