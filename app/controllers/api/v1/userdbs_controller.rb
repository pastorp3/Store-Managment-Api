module Api 
	module V1
		class UserdbsController < ApplicationController
			before_action :authenticate_token
			def index
				@userdbs = Token.user_dbs(check_token)

				render json: UserdbsRepresenter.new(@userdbs).as_json
			end
		end
	end
end