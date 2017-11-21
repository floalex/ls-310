Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  
  root 'pages#front'
  get '/home', to: 'videos#index'
  get '/register', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy'
  
  resources :categories, only: [:show]
  resources :queue_items, only: [:create, :destroy]
  post 'update_queue', to: 'queue_items#update_queue'
  
  get '/my_queue', to: 'queue_items#index'
  
  resources :videos, only: [:show] do
    collection do
      get "/search", to: "videos#search"
    end
    resources :reviews, only: [:create]
  end
  
  resources :users, only: [:create, :show]
end
