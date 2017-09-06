Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  
  root 'videos#index'
  get '/home', to: 'videos#index'
  get '/register', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  
  resources :videos, only: [:show] do
    collection do
      get "/search", to: "videos#search"
    end
  end
  
  resources :users, only: [:create]
end
