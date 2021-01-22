module RequestHelper
	def response_body
		JSON.parse(response.body)
	end

	def clean_data
		User.delete_all
		Token.delete_all
		UserDb.delete_all
		Order.delete_all
		Product.delete_all
	end
end