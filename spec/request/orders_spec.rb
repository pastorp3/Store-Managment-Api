require 'rails_helper'

describe 'Orders', type: :request do
	describe 'GET /orders' do
		let(:user_db) { UserDb.create!(name: 'Testing')}
		let!(:user) { User.create!(username: 'Juan', email: 'pastor@email.com', password: '123456', user_db_id: user_db.id)}
		entoken = AuthenticationTokenService.call
		let!(:token)  {Token.create!(token: entoken, user_id: user.id)}
		let!(:product1) {Product.create!(name: 'Apple', stock: 12, price: 20, user_db_id: user_db.id)}
		let!(:order) {Order.create!(product_id: product1.id, user_db_id: user_db.id)}

		it 'Returns all orders' do
			get "/api/v1/orders?key=#{Token.last.token}"

			expect(response).to have_http_status(:ok)
			expect(response_body).to eq(
				[
				{
					"created"=>order.created_at.strftime("%Y-%m-%d"),
					 "order_id"=>order.id,
					  "product"=>{"name"=>"Apple",
					   "price"=>20}
				}
				])
		end

		it 'Returns a single order' do
			get "/api/v1/order/#{order.id}?key=#{Token.last.token}"

			expect(response).to have_http_status(:ok)
			expect(response_body).to eq(
				{
					"created"=>order.created_at.strftime("%Y-%m-%d"),
					 "order_id"=>order.id,
					  "product"=>{"name"=>"Apple",
					   "price"=>20}
				}
				)
		end

		it 'Returns error when the id is not valid' do
			get "/api/v1/order/1?key=#{Token.last.token}"

			expect(response).to have_http_status(:unprocessable_entity)
		end
	end

	describe 'POST orders' do

		let(:user_db) { UserDb.create!(name: 'Testing')}
		let!(:user) { User.create!(username: 'Juan', email: 'pastor@email.com', password: '123456', user_db_id: user_db.id)}
		entoken = AuthenticationTokenService.call
		let!(:token)  {Token.create!(token: entoken, user_id: user.id)}
		let!(:product1) {Product.create!(name: 'Apple', stock: 12, price: 20, user_db_id: user_db.id)}


		it 'Succes created a new order' do 
			post "/api/v1/orders?key=#{Token.last.token}", params: { product_id: product1.id}

			expect(response).to have_http_status(:created)
			expect(response_body).to eq(
				{
					"created"=>Order.last.created_at.strftime("%Y-%m-%d"),
					 "order_id"=>Order.last.id,
					  "product"=>{"name"=>"Apple",
					   "price"=>20}
				}
				)
		end

		it 'Returns error if the product do not exist' do
			post "/api/v1/orders?key=#{Token.last.token}", params: { product_id: 1}

			expect(response).to have_http_status(:unprocessable_entity)
			expect(response_body).to eq({
				"error"=>"Validation failed: Product must exist"
			})
		end

		it 'Returns error if the product_id is missing' do
			post "/api/v1/orders?key=#{Token.last.token}"

			expect(response).to have_http_status(:unprocessable_entity)
			expect(response_body).to eq({
				"error" => "Validation failed: Product must exist, Product can't be blank"
			})
		end
	end

	describe 'PUT/PATCH order' do

		let(:user_db) { UserDb.create!(name: 'Testing')}
		let!(:user) { User.create!(username: 'Juan', email: 'pastor@email.com', password: '123456', user_db_id: user_db.id)}
		entoken = AuthenticationTokenService.call
		let!(:token)  {Token.create!(token: entoken, user_id: user.id)}
		let!(:product1) {Product.create!(name: 'Apple', stock: 12, price: 20, user_db_id: user_db.id)}
		let!(:product2) {Product.create!(name: 'Orange', stock: 10, price: 12, user_db_id: user_db.id)}
		let!(:order) {Order.create!(product_id: product1.id, user_db_id: user_db.id)}


		it 'Return updated order with different product' do
			put "/api/v1/order/#{order.id}?key=#{Token.last.token}", params: {product_id: product2.id}

			expect(response).to have_http_status(:ok)

			expect(response_body).to eq(
				{
					"created"=>Order.last.created_at.strftime("%Y-%m-%d"),
					 "order_id"=>order.id,
					  "product"=>{"name"=>"Orange",
					   "price"=>12}
				}
			)
		end

		it 'Returns error when id is not valid' do
			put "/api/v1/order/1?key=#{Token.last.token}", params: {product_id: product2.id}

			expect(response).to have_http_status(:unprocessable_entity)
		end
	end

	describe 'DELETE order' do

		let(:user_db) { UserDb.create!(name: 'Testing')}
		let!(:user) { User.create!(username: 'Juan', email: 'pastor@email.com', password: '123456', user_db_id: user_db.id)}
		entoken = AuthenticationTokenService.call
		let!(:token)  {Token.create!(token: entoken, user_id: user.id)}
		let!(:product1) {Product.create!(name: 'Apple', stock: 12, price: 20, user_db_id: user_db.id)}
		let!(:order) {Order.create!(product_id: product1.id, user_db_id: user_db.id)}

		it 'Return succes after delete order' do
			delete "/api/v1/order/#{order.id}?key=#{Token.last.token}"

			expect(response).to have_http_status(:no_content)
			expect(Order.count).to eq(0)
		end

		it 'Returns error when id is not valid' do
			delete "/api/v1/order/1?key=#{Token.last.token}"

			expect(response).to have_http_status(:unprocessable_entity)
		end
	end
end