# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.0'

gem 'rails', '~> 7.1.3'

gem 'bootsnap', require: false
gem 'devise'
gem 'devise_invitable', '~> 2.0.0'
gem 'mysql2', '~> 0.5'
gem 'puma', '>= 5.0'
gem 'rubocop', '~> 1.62', require: false
gem 'sidekiq'
gem 'tzinfo-data', platforms: %i[windows jruby]
gem 'httparty'
gem 'singleton'

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
end

group :development do
  gem 'rubocop-rails', require: false
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  gem 'simplecov'
  gem 'webdrivers'
end
