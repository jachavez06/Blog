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

# Windows does not include zoneinfo files
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby] # Timezone awareness

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  
  # Debug
  gem 'byebug' #
  gem 'pry-rails' #
  gem 'pry-byebug' #
  gem 'better_errors' #
  gem 'binding_of_caller' #
  gem 'meta_request'
  gem 'traceroute'
  
  # Code Optimization
  gem 'bullet'

  # Code style
  gem 'pronto'
  gem 'rubocop', '~> 0.49.1'
  gem 'rails_best_practices'

  # Code style runners
  gem 'pronto-rubocop'
  gem 'pronto-rails_best_practices'

end

group :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end