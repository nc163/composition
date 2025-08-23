# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in component.gemspec
gemspec

group :development do
  gem 'dotenv'
  gem 'guard-yard'
  gem 'lookbook', '~> 2.3'
  gem 'yard'
end

group :development, :test do
  gem 'guard-rspec', require: false
  gem 'rails', '~> 7.0'
  gem 'rspec-rails', '~> 6.0'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'webrick', '~> 1.8'
end

group :test do
  gem 'capybara', '~> 3.39'
  gem 'rspec'
end
