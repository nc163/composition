# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in component.gemspec
gemspec

gem "view_component", "~> 3.22"

group :development do
  gem "lookbook", "~> 2.3"
  gem 'yard'
  gem 'guard-yard'
end

group :development, :test do
  gem "ostruct"
  gem "webrick", "~> 1.8"
  gem "rails", "~> 7.0"
  gem "web-console"
  gem "nokogiri", "~> 1.16"
end

group :test do
  gem "rspec-rails", "~> 6.0"
  gem "capybara", "~> 3.39"
end
