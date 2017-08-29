source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'bootstrap', '4.0.0.alpha6'
gem 'ckeditor', '4.2.4'
#gem 'exception_handler'
gem 'jquery-rails', '4.3.1'
gem 'meta-tags', '2.4.1'
gem 'paperclip', '5.1.0'
gem 'pg', '0.21.0'
gem 'puma', '3.9.1'
gem 'rails', '5.1.3'
gem 'rails-assets-tether', '1.4.0', source: 'https://rails-assets.org'
gem 'redcarpet', '3.4.0'
gem 'rouge', '2.1.1'
gem 'sass-rails', '5.0.6'
gem 'sprockets-rails', require: 'sprockets/railtie'
gem 'uglifier', '3.2.0'
gem 'will_paginate', '~> 3.1.0'


gem 'coffee-rails', '4.2.2'
gem 'jbuilder', '2.7.0'
gem 'turbolinks', '5.0.1'

gem 'ahoy_matey' 
gem 'bcrypt', '3.1.11'
gem 'sitemap_generator'
gem 'fog-aws'
gem 'chartkick'
gem 'groupdate'
gem 'blazer'

gem 'rails-erd', require: false, group: :development

group :development do
  gem 'listen', '3.1.5'
  gem 'web-console', '3.5.1'
  gem 'spring', '2.0.2'
  gem 'spring-watcher-listen', '2.0.1'

  # Debug
  #gem 'better_errors', '2.3.0'
  gem 'binding_of_caller', '0.7.2'
  gem 'byebug', '9.0.6'
  gem 'meta_request', '0.4.3'
  gem 'pry-byebug', '3.4.2'
  gem 'pry-rails', '0.3.6'
  gem 'traceroute', '0.5.0'

  # Code Optimization
  gem 'bullet', '5.6.1'

  # Code style
  gem 'pronto', '0.9.4'
  gem 'rails_best_practices', '1.19.0'
  gem 'rubocop', '0.49.1'

  # Code style runners
  gem 'pronto-rails_best_practices', '0.9.0'
  gem 'pronto-rubocop', '0.9.0'
end

group :test do
  gem 'byebug', '9.0.6', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '2.15.1'
  gem 'selenium-webdriver', '3.4.4'
end
