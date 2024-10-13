source 'https://rubygems.org'

ruby '3.3.5'

gem 'rails', '~> 7.2.1'
gem 'sprockets-rails'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'

gem 'importmap-rails'
gem 'turbo-rails'

gem 'bootsnap', require: false

gem 'dotenv-rails'
gem 'parallel'
gem 'ruby-progressbar'
gem 'pagy', '~> 9.1'

group :development, :test do
  gem 'debug', platforms: %i[mri windows], require: 'debug/prelude'
  gem 'brakeman', require: false
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'guard-rspec', require: false
  gem 'guard-rubocop'
end

group :development do
  gem 'web-console'
  gem 'rails-erd'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 6.0'
end
