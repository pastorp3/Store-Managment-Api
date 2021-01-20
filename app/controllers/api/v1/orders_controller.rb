module Api
	module V1
		class OrdersController < ApplicationController
			before_action :authenticate_token
			before_action :set_order, only: [:update]
			def index

				@orders = Token.user_orders(check_token)

				render json: OrdersRepresenter.new(@orders).as_json
			end

			def create 
				user_db = Token.get_user_db_id(check_token)
				@order = Order.create!(order_params.merge(user_db_id: user_db))

				if @order.save
		          render json: OrderRepresenter.new(@order).as_json, status: :created
		        else
		          render json: @order.errors, status: :unprocessable_entity
		        end 
			end

			def update
				@order.update!(order_params)
				render json: OrderRepresenter.new(@order).as_json, status: :ok
			end

			private 

			def set_order
				@order ||= Order.find(params[:id])
			end

			def order_params
				params.permit(:product_id)
			end
		end
	end
end
