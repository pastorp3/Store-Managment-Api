class OrderRepresenter < Api::V1::OrdersController 
	def initialize(order)
		@order = order
	end

	def product_json(item)
		{
			name: item.name,
			price: item.price
		}
	end

	def as_json

			{
				order_id: order.id,
				product: product_json(order.product),
				created: order.created_at.strftime("%Y-%m-%d")
			}
		
	end

	private

	attr_reader :order


end