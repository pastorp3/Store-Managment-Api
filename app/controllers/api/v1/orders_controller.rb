module Api
	module V1
		class OrdersController < ApplicationController
			def index
				@orders = Order.includes(:product)

				render json: OrdersRepresenter.new(@orders).as_json
			end
		end
	end
end
