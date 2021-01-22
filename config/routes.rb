Rails.application.routes.draw do
  namespace :api do
  	namespace :v1 do 
  		post '/register', to: 'registration#create'
  		resources :products , except: [:show,:destroy,:update]
  		get '/product/:id', to: 'products#show'
  		delete '/product/:id', to: 'products#destroy'
  		put '/product/:id', to: 'products#update'
  		patch '/product/:id',to: 'products#update'
  		resources :orders , except: [:show,:destroy,:update]
  		put '/order/:id', to: 'orders#update'
  		patch '/order/:id', to: 'orders#update'
  		get '/my-db', to: 'userdbs#index'
  	end
  end
end
