require 'rails_helper'

describe 'Products', type: :request do

	describe 'GET /products' do
		before do
			User.delete_all
			Product.delete_all
		end
		let(:user_db) { UserDb.create!(name: 'Testing')}
		let!(:user) { User.create!(username: 'Pastor', email: 'pastor@email.com', password: '123456', user_db_id: user_db.id)}
		entoken = AuthenticationTokenService.call
		let!(:token)  {Token.create!(token: entoken, user_id: user.id)}
		let!(:product1) {Product.create!(name: 'Apple', stock: 12, price: 20, user_db_id: user_db.id)}
		let!(:product2) {Product.create!(name: 'Banana', stock: 20, price: 12, user_db_id: user_db.id)}

		it 'Returns all products' do
			get "/api/v1/products?key=#{Token.last.token}"

			expect(response).to have_http_status(:ok)
			expect(response_body).to eq(
				[
					{
       					"id"=>product2.id, 
       					"name"=>"Banana", 
       					"price"=>12, 
       					"stock"=>20
		       		},
					{
						"id"=>product1.id,
						"name"=>"Apple",
						"price"=>20,
						"stock"=>12
					}
		       	]

				)
		end

		it 'Returns unathorized if the token is not valid' do
			get "/api/v1/products?key=123456"

			expect(response).to have_http_status(:unauthorized)
		end
	end

	describe 'POST /products' do
		let(:user_db) { UserDb.create!(name: 'Testing')}
		let!(:user) { User.create!(username: 'Pastor', email: 'pastor@email.com', password: '123456', user_db_id: user_db.id)}
		entoken = AuthenticationTokenService.call
		let!(:token)  {Token.create!(token: entoken, user_id: user.id)}
		it 'Create a new product' do 
			post "/api/v1/products?key=#{Token.last.token}" , params: {name: 'Pear', stock: 10, price: 12, user_db_id: user_db.id}

			expect(response).to have_http_status(:created)
			expect(Product.count).to eq(1)
						expect(response_body).to eq(
					{
       					"id"=>Product.last.id, 
       					"name"=>"Pear", 
       					"price"=>12, 
       					"stock"=>10
		       		})

		end

		it 'Returns error when name is missing' do 
			post "/api/v1/products?key=#{Token.last.token}" , params: { stock: 10, price: 12, user_db_id: user_db.id}

			expect(response).to have_http_status(:unprocessable_entity)
			expect(response_body).to eq({
				"error" => "Validation failed: Name can't be blank"
			})
			
		end

		it 'Returns error when stock is missing' do 
			post "/api/v1/products?key=#{Token.last.token}" , params: {name: 'Pear', price: 12, user_db_id: user_db.id}


			expect(response).to have_http_status(:unprocessable_entity)
			expect(response_body).to eq({
				"error" => "Validation failed: Stock can't be blank"
			})
		end

		it 'Returns error when price is missing' do
			post "/api/v1/products?key=#{Token.last.token}" , params: {name: 'Pear', stock: 10,  user_db_id: user_db.id}

			expect(response).to have_http_status(:unprocessable_entity)
			expect(response_body).to eq({
				"error" => "Validation failed: Price can't be blank"
			})
		end
	end

	describe 'UPDATE product' do
		let(:user_db) { UserDb.create!(name: 'Testing')}
		let!(:user) { User.create!(username: 'Pastor', email: 'pastor@email.com', password: '123456', user_db_id: user_db.id)}
		entoken = AuthenticationTokenService.call
		let!(:token)  {Token.create!(token: entoken, user_id: user.id)}
		let!(:product1) {Product.create!(name: 'Apple', stock: 12, price: 20, user_db_id: user_db.id)}

		it 'Returns a product with a different name' do
			patch "/api/v1/product/#{product1.id}?key=#{Token.last.token}", params: {name: 'Banana'}

			expect(response).to have_http_status(:ok)
			expect(response_body).to eq(
					{
       					"id"=>product1.id, 
       					"name"=>"Banana", 
       					"price"=>20, 
       					"stock"=>12
		       		})

		end

		it 'Returns a product with a different stock' do
			patch "/api/v1/product/#{product1.id}?key=#{Token.last.token}", params: {stock: 20}

			expect(response).to have_http_status(:ok)
			expect(response_body).to eq(
					{
       					"id"=>product1.id, 
       					"name"=>"Apple", 
       					"price"=>20, 
       					"stock"=>20
		       		})

		end

		it 'Returns a product with a different price' do
			patch "/api/v1/product/#{product1.id}?key=#{Token.last.token}", params: {price: 10}

			expect(response).to have_http_status(:ok)
			expect(response_body).to eq(
					{
       					"id"=>product1.id, 
       					"name"=>"Apple", 
       					"price"=>10, 
       					"stock"=>12
		       		})

		end

		it 'Returns error when id is not valid' do 
			patch "/api/v1/product/1?key=#{Token.last.token}", params: {name: 'Banana'}

			expect(response).to have_http_status(:unprocessable_entity)
		end
	end

	describe 'DELETE /product/:id' do
		let(:user_db) { UserDb.create!(name: 'Testing')}
		let!(:user) { User.create!(username: 'Pastor', email: 'pastor@email.com', password: '123456', user_db_id: user_db.id)}
		entoken = AuthenticationTokenService.call
		let!(:token)  {Token.create!(token: entoken, user_id: user.id)}
		let!(:product1) {Product.create!(name: 'Apple', stock: 12, price: 20, user_db_id: user_db.id)}

		it 'Return succes to delete a product' do 
			delete "/api/v1/product/#{product1.id}?key=#{Token.last.token}"

			expect(response).to have_http_status(:no_content)

		end

		it 'Returns error when id is not valid' do 
			delete "/api/v1/product/1?key=#{Token.last.token}"

			expect(response).to have_http_status(:unprocessable_entity)
		end
	end
end