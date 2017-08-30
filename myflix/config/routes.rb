Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  
  root 'videos#index'
  get '/home', to: 'videos#index'
  
  resources :videos, only: [:show] do
    collection do
      get "/search", to: "videos#search"
    end
  end
end
