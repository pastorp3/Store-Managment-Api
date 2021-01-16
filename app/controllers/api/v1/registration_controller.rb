module Api
	module V1
		class RegistrationController < ApplicationController
			include BCrypt
			def create
				@user = User.new(params[:user])
				@user.username = params[:username]
  				@user.password = encrypt_password 
  				@user.email = params[:email]
  				@user.save!

  				token = AuthenticationTokenService.call
  				entoken = Token.create!(token: encrypt_token(token),  user_id: @user.id)
 
  				render json: UserRepresenter.new(@user,token).as_json

			end

			private 

			def encrypt_password
				BCrypt::Password.create(params[:password])
			end

			def encrypt_token(token)
				BCrypt::Password.create(token)
			end

			def user_params
				params.require(:user).permit(:user,:email,:password)
			end
		
		end
	end
end