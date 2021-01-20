module Api
	module V1
		class ProductsController < ApplicationController
			before_action :authenticate_token
			before_action :set_product, only: [:destroy, :update]
			def index
				@products = Token.user_products(check_token)
				render json: ProductsRepresenter.new(@products).as_json
			end

			def create
				user_db = Token.get_user_db_id(check_token)
				@product = Product.create!(product_params.merge(user_db_id: user_db))
				
		        if @product.save
		          render json: ProductRepresenter.new(@product).as_json, status: :created
		        else
		          render json: @product.errors, status: :unprocessable_entity
		        end 
			end

			def destroy
					@product.destroy!
					head :no_content
			end

			def update 
					@product.update!(product_params)
					render json: ProductRepresenter.new(@product).as_json, status: :ok
			end

			private 

			def set_product
				@product ||= Product.find(params[:id])
			end

			def product_params
				params.permit(:name,:stock,:price)
			end
		end
	end
end