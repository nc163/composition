# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in component.gemspec
gemspec

gem 'actionview', '~> 7.0'
gem 'activesupport', '~> 7.0'
gem 'view_component', '~> 3.22'

group :development do
  gem 'guard-yard'
  gem 'lookbook', '~> 2.3'
  gem 'yard'
end

group :development, :test do
  gem 'nokogiri', '~> 1.16'
  gem 'ostruct'
  gem 'rails', '~> 7.0'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'web-console'
  gem 'webrick', '~> 1.8'
end

group :test do
  gem 'capybara', '~> 3.39'
  gem 'rspec-rails', '~> 6.0'
end
