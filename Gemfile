source 'https://rubygems.org'

# Rails
gem 'rails',        '4.1.1'

# Storage
gem 'mongo'
gem 'bson',         '2.2.0'
gem 'bson_ext'
gem 'mongoid',      github: 'mongoid/mongoid'

# Plugins
gem 'decent_exposure'

# Authentication
gem 'omniauth-facebook'

# Setup
gem 'figaro'

# Frontend
gem 'sass-rails',   '~> 4.0.3'
gem 'uglifier',     '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'slim-rails'
gem 'bootstrap-sass'

# Development Tools
group :development do
  gem 'spring'
  gem 'mailcatcher'
  gem 'rails_layout'
end

# Test suite
group :development, :test do
  gem 'spring-commands-rspec'
  gem 'rspec-rails'
  gem 'rb-fsevent' if `uname` =~ /Darwin/
  gem 'factory_girl_rails'
  gem 'quiet_assets'
end

group :test do
  gem 'capybara'
  gem 'capybara-email'
  gem 'database_cleaner',     require: false
  gem 'simplecov',            require: false
  gem 'launchy'
  gem 'ffaker'
end

# Misc
gem 'sdoc', '~> 0.4.0', group: :doc
