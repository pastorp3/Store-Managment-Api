module Api
	module V1
		class RegistrationController < ApplicationController
			include BCrypt
			def create
				@user_Db = UserDb.create!(name: params[:dbname])
				@user = User.create!(username: params[:username], password: encrypt(params[:password]), email: params[:email], user_db_id: @user_Db.id)
  				token = AuthenticationTokenService.call
  				entoken = Token.create!(token: token,  user_id: @user.id)
 
  				render json: UserRepresenter.new(@user,token).as_json

			end

			private 

			def encrypt(item)
				BCrypt::Password.create(item)
			end

			def user_params
				params.require(:user).permit(:user,:email,:password)
			end
		
		end
	end
end