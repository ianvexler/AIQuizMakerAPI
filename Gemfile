source "https://rubygems.org"

ruby "3.3.0"

gem "rails", "~> 7.1.3"

gem "mysql2", "~> 0.5"
gem "puma", ">= 5.0"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false
gem 'sidekiq'
gem 'devise'
gem 'devise_invitable', '~> 2.0.0'

group :development, :test do
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem 'rails-controller-testing'
  gem "selenium-webdriver"
  gem 'simplecov'
  gem 'webdrivers'
end