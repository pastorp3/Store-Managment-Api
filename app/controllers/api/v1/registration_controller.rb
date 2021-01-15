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

  				render json: { 'user' => @user } , statuscode: :created

			end

			private 

			def encrypt_password
				BCrypt::Password.create(params[:password])
			end

			def user_params
				params.require(:user).permit(:user,:email,:password)
			end

		
		end
	end
end