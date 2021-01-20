class ApplicationController < ActionController::API
	class AuthenticationError < StandardError; end
	  include SetToken

	  rescue_from AuthenticationError, with: :handle_unauthenticated
	  

	  def authenticate_token
	  	raise AuthenticationError unless check_token
	  end

	  def check_token
	  	status ||= Token.find_by(token: session[:token])
	  end

	   def handle_unauthenticated
	   		message = 'Invalid token'
            render json: { error:  message }, status: :unauthorized
       end

end
