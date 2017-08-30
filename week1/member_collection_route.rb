resources :todos, only: [:index] do
  collection do
    get 'search', to: 'todos#search' #search_todos_path -> todos/search
  end
  
  member do
    post 'highlight', to: 'todos#highlight' #search_todos_path(todo) -> todos/:id/search
  end
end