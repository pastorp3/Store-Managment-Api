Rails.application.routes.draw do
  namespace :api do
  	namespace :v1 do 
  		post '/register', to: 'registration#create'
  		get '/products', to: 'products#index'
  		get '/orders', to: 'orders#index'
  	end
  end
end
