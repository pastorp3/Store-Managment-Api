class UserRepresenter < Api::V1::RegistrationController
	def initialize(user,token)
		@user = user
		@token = token
	end

	def as_json
		{
			username: user.username,
			email: user.email,
			token: token
		}
	end

	private

	attr_reader :user
	attr_reader :token

end