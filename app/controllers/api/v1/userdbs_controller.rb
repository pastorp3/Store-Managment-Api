module Api 
	module V1
		class UserdbsController < ApplicationController
			def index
				@userdbs = UserDb.all

				render json: UserdbsRepresenter.new(@userdbs).as_json
			end
		end
	end
end