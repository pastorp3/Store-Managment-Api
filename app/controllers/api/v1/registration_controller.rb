module Api
	module V1
		class RegistrationController < ApplicationController
			include BCrypt
			rescue_from ActiveRecord::RecordInvalid, with: :parameter_missing

			def create
				@user_Db = UserDb.create!(name: params[:dbname])
				@user = User.create!(username: params[:username], password: encrypt(params[:password]), email: params[:email], user_db_id: @user_Db.id)
  				token = AuthenticationTokenService.call(@user.id)
  				entoken = Token.create!(token: token,  user_id: @user.id)
 
  				render json: UserRepresenter.new(@user,token).as_json, status: :created

			end

			private 

			def encrypt(item)
				if item
					BCrypt::Password.create(item)
				end
			end

			def user_params
				params.require(:user).permit(:user,:email,:password)
			end

			def parameter_missing(e)
    			render json: {error: e.message}, status: :unprocessable_entity
    		end

		
		end
	end
end