class UserRepresenter < Api::V1::RegistrationController
	def initialize(user)
		@user = user
	end

	def as_json
		{
			id: user.id,
			username: user.username,
			email: user.email
		}
	end

	private

	attr_reader :user

end