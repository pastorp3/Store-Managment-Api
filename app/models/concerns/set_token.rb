module SetToken
	extend ActiveSupport::Concern
	included do 
		before_action :set_token
	end

	def set_token
	 	session[:token] = params[:key] if params[:key]
	end
end