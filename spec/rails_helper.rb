# frozen_string_literal: true

# This file is copied to spec/ when you run 'rails generate rspec:install'
require "spec_helper"
ENV["RAILS_ENV"] ||= "test"

require File.expand_path('../config/environment', __dir__)
require 'rspec/rails'
require "active_support/all"
require 'view_component/test_helpers'
require 'view_component/system_test_helpers'

# require "simplecov"
# SimpleCov.start("rails")
