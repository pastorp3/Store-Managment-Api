require 'rails_helper'

describe 'Registration', type: :request do
	describe 'POST /register' do
		it 'Register the user' do 
			post '/api/v1/register', params: {username: 'Test',email: 'test@test.com',  password: '123456'}

			expect(response).to have_http_status(:created)
		end

		it 'Returns error when the password is missing' do
			post '/api/v1/register', params: {username: 'Test',email: 'test@test.com'}

			expect(response).to have_http_status(:unprocessable_entity)
			expect(response_body).to eq({
				"error"=>"Validation failed: Password can't be blank"
			})
		end

		it 'Returns error when the username is missing' do
			post '/api/v1/register', params: {email: 'test@test.com',  password: '123456'}

			expect(response).to have_http_status(:unprocessable_entity)
			expect(response_body).to eq({
				"error"=>"Validation failed: Username can't be blank"
			})
		end

		it 'Returns error when the email is missing' do
			post '/api/v1/register', params: {username: 'Test',  password: '123456'}

			expect(response).to have_http_status(:unprocessable_entity)
			expect(response_body).to eq({
				"error"=>"Validation failed: Email can't be blank"
			})
		end

		
	end
end