source 'https://rubygems.org'

gem 'rails', '3.2.3'

group :production do
  gem 'pg'
  gem 'heroku'
end

gem 'bootstrap-sass'
gem 'will_paginate'
gem 'bootstrap-will_paginate'


group :development, :test do
  gem 'debugger'
  gem 'mysql2'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :test do
  gem 'capybara', '1.1.2'
  gem 'launchy'
  gem 'rspec-rails', '2.9.0'
  gem 'spork', '0.9.0'
  gem 'factory_girl_rails', '1.4.0'
  gem 'cucumber-rails', '1.2.1', require: false
  gem 'database_cleaner', '0.7.0'
end