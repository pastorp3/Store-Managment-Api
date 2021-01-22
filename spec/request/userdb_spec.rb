require 'rails_helper'

describe 'Userdbs', type: :request do
	User.delete_all
	Token.delete_all
	UserDb.delete_all
	describe 'GET /my-db' do
		db = UserDb.create!(name: 'Testing')
		@user = User.create!(username: 'Test2', email: 'Test@email.com', password: '123456', user_db_id: db.id)
		entoken = AuthenticationTokenService.call
		token = Token.create!(token: entoken, user_id: @user.id)

		it 'Returns the user db data' do
			get "/api/v1/my-db?key=#{token.token}"

			expect(response).to have_http_status(:ok)
			expect(response_body).to eq(
				[{
				"name"=>"Testing",
				 "orders"=>0,
				  "products"=>0
			}])
		end

		it 'Returns error when key is no valid' do
			get "/api/v1/my-db?key=12345"

			expect(response).to have_http_status(:unauthorized)
		end
	end

end