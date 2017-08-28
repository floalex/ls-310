resources :todos, only: [:index] do
  collection do
    get 'search', to: 'todos#search' #search_todo -> todos/search
  end
  
  member do
    post 'highlight', to: 'todos#highlight'
  end
end