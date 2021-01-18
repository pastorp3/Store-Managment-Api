module Api
	module V1
		class OrdersController < ApplicationController
			before_action :authenticate_token
			def index

				@orders = Token.user_orders(check_token)

				render json: OrdersRepresenter.new(@orders).as_json
			end
		end
	end
end
