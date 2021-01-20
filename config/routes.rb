Rails.application.routes.draw do
  namespace :api do
  	namespace :v1 do 
  		post '/register', to: 'registration#create'
  		resources :products , except: [:show,:destroy,:update]
  		delete '/product/:id', to: 'products#destroy'
  		put '/product/:id', to: 'products#update'
  		patch '/product/:id',to: 'products#update'
  		get '/orders', to: 'orders#index'
  		get '/my-db', to: 'userdbs#index'
  	end
  end
end
