# frozen_string_literal: true

require 'bundler/setup'
require 'rails'
require 'action_controller'
require 'view_component/test_helpers'
require 'view_component/system_test_helpers'
require 'capybara/rspec'
require 'atomic_design'

ENV['RAILS_ENV'] = 'test'

# TODO: view_component のヘルパー機能で代替できる
# Dummy Railsアプリケーションの設定
class DummyApp < Rails::Application
  config.root = __dir__
  config.session_store :cookie_store, key: 'cookie_store_key'
  config.secret_key_base = 'secret_key_base'
  config.logger = Logger.new($stdout)
  Rails.logger = config.logger
  config.eager_load = false
  config.consider_all_requests_local = true
end

Rails.application.initialize!

RSpec.configure do |config|
  config.include ViewComponent::TestHelpers, type: :component
  config.include ViewComponent::SystemTestHelpers, type: :component
  config.include Capybara::RSpecMatchers, type: :component

  config.before(:each, type: :component) do
    # 各テスト前にビューコンテキストをリセット
    @vc_test_controller = nil
  end

  Dir[File.join(File.dirname(__FILE__), 'fixtures', '**', '*.rb')].sort.each { |f| require f }
end
