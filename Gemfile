source 'https://rubygems.org'

gem 'rails', '3.2.12'

gem 'bootstrap-sass', '~> 2.1.0.0'
gem 'jquery-rails'
gem 'redcarpet', '~> 2.2.2'
gem 'simple_form', '~> 2.0.4'
gem 'sqlite3'

# Authentication
gem 'omniauth', '1.0.3'
gem 'omniauth-openid', '1.0.1'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'foreman'
  # Guard for autorunning tests
  gem 'guard', '~> 1.6.2'
  gem 'guard-cucumber', '~> 1.3.2'
  gem 'guard-rspec', '~> 2.4.1'
  gem 'rb-fsevent', '~> 0.9.1'
  gem 'terminal-notifier-guard'
end

group :development, :test do
  gem 'rspec-rails', '~> 2.9'
end

group :test do
  gem 'cucumber-rails', '1.3.0', require: false
  gem 'database_cleaner', '~> 0.9.0'
  gem 'factory_girl_rails', '~> 4.2.0'
  gem 'shoulda-matchers', '~> 1.4.0'
end