# frozen_string_literal: true

require "bundler/setup"
require "rails"
require "view_component/test_helpers"
require "capybara/rspec"

# Rails環境のセットアップ
ENV["RAILS_ENV"] = "test"

# Dummy Railsアプリケーションの設定
class DummyApp < Rails::Application
  config.root = __dir__
  config.session_store :cookie_store, key: "cookie_store_key"
  config.secret_key_base = "secret_key_base"
  config.logger = Logger.new($stdout)
  Rails.logger = config.logger
  config.eager_load = false
  config.consider_all_requests_local = true
end

Rails.application.initialize!

# ViewComponentのテストヘルパーを読み込み
require "view_component/test_helpers"
require "capybara/rspec"

RSpec.configure do |config|
  config.include ViewComponent::TestHelpers, type: :component
  config.include Capybara::RSpecMatchers, type: :component
  
  config.before(:each, type: :component) do
    # 各テスト前にビューコンテキストをリセット
    @vc_test_controller = nil
  end
end

# Componentライブラリを読み込み
require_relative "../lib/design"
