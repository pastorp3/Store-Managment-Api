class OrdersRepresenter < Api::V1::OrdersController 
	def initialize(orders)
		@orders = orders
	end

	def product_json(item)
		{
			name: item.name,
			price: item.price
		}
	end

	def as_json
		orders.map do |order|
			{
				order_id: order.id,
				product: product_json(order.product),
				created: order.created_at
			}
		end
	end

	private

	attr_reader :orders


end