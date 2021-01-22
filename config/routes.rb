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
      get '/order/:id', to: 'orders#show'
  		put '/order/:id', to: 'orders#update'
  		patch '/order/:id', to: 'orders#update'
      delete '/order/:id', to: 'orders#destroy'
  		get '/my-db', to: 'userdbs#index'
  	end
  end
end
