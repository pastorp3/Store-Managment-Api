class AuthenticationTokenService
	HMAC_SECRET = ENV.fetch('HMAC_SECRET')
	ALGORITHM_TYPE = ENV.fetch('ALGORITHM_TYPE')

	def self.call 
		payload = {user_id: rand()}

		JWT.encode payload, HMAC_SECRET, ALGORITHM_TYPE
	end
end