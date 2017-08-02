Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor' # Articles
  root 'welcome#index'  
  resources :articles 
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get '*path', to: 'errors#no_page'
end
