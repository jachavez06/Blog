Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  root 'welcome#index'
  resources :articles
  get 'admin', to: 'admins#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get '/articles/tag/:id', to: 'tags#show', as: 'articles_with_tags'
  get '/sitemap.xml', to: redirect("https://s3-us-west-2.amazonaws.com/jchavez-guides-sitemap/sitemaps/sitemap.xml.gz", status: 301)

  constraints AdminConstraint.new do 
    mount Blazer::Engine, at: 'analytics'
  end

  namespace :charts do
    get 'new-users'
  end
end
