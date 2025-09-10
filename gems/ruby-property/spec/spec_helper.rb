# frozen_string_literal: true

require 'bundler/setup'
# require 'view_component'
require 'view_component/test_helpers'
require 'view_component/system_test_helpers'
require 'property'

ENV['RAILS_ENV'] = 'test'

RSpec.configure do |config|
  Dir[File.join(File.dirname(__FILE__), 'fixtures', '**', '*.rb')].sort.each { |f| require f }
end
