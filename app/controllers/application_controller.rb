class ApplicationController < ActionController::API
	class AuthenticationError < StandardError; end
	  include SetToken

	  rescue_from AuthenticationError, with: :handle_unauthenticated
	  rescue_from ActiveRecord::RecordInvalid, with: :parameter_missing
	  rescue_from ActiveRecord::RecordNotFound, with: :invalid_id
	  

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

       def parameter_missing(e)
    			render json: {error: e.message}, status: :unprocessable_entity
    	end

    	def invalid_id(e)
    			render json: {error: e.message}, status: :unprocessable_entity
    	end
end
