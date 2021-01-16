module Api
	module V1
		class ProductsController < ApplicationController
			def index
				@products = Product.all

				render json: ProductsRepresenter.new(@products).as_json
			end
		end
	end
end