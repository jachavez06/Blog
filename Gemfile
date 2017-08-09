source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'bootstrap', '~> 4.0.0.alpha6'
gem 'ckeditor'
#gem 'exception_handler'
gem 'jquery-rails'
gem 'meta-tags'
gem 'paperclip'
gem 'pg'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.2'
gem 'rails-assets-tether', '>= 1.3.3', source: 'https://rails-assets.org'
gem 'redcarpet'
gem 'rouge'
gem 'sass-rails', '~> 5.0'
gem 'sprockets-rails', require: 'sprockets/railtie'
gem 'uglifier', '>= 1.3.0'
gem 'will_paginate', '3.1.5'

gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'turbolinks', '~> 5'

gem 'bcrypt', '~> 3.1.7'

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Static code analyzer
  gem 'rubocop', '~> 0.49.1', require: false
  # Optimization
  gem 'bullet'
  # Routes
  gem 'traceroute'
  gem 'better_errors', git: 'https://github.com/charliesome/better_errors.git', branch: 'master'
  gem "pry-rails"
  gem 'meta_request'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end



# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
