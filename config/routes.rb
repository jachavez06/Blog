Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root 'welcome#index'
  resources :articles
  get 'admin', to: 'admins#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'  
  match "*path", to: "welcome#catch_404", via: :all  
end
