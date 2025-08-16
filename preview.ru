#!/bin/ruby

require 'bundler/setup'

require 'webrick'
require 'rails'
require 'active_support'
require 'active_support/core_ext'
require 'action_controller/railtie'
require 'action_view/railtie'

require 'web_console'
require 'view_component'
require 'lookbook'
require 'atomic_design/engine'

# 簡単なRailsアプリケーション
module AtomicDesign
  class Application < Rails::Application # :nodoc:
    config.load_defaults 7.0
    config.root = __dir__
    config.eager_load = false

    config.secret_key_base = 'demo_secret_key_base_'
    config.session_store :cookie_store, key: '_component_demo_session'
    config.logger = Logger.new(STDOUT)
    config.log_level = :info

    config.web_console.allowed_ips = '0.0.0.0/0'

    # Lookbookの設定
    config.autoload_paths += Dir[Rails.root.join('previews')]
    config.view_component.preview_paths = [File.expand_path('previews', __dir__)]

    # https://lookbook.build/guide/config
    # config.view_component.default_preview_layout = "component_preview"
    config.lookbook.project_name = 'AtomicDesign Preview'
    config.lookbook.preview_collection_label = 'Components'
    config.lookbook.project_logo = false
    config.lookbook.ui_favicon = false
    config.lookbook.reload_on_change = false
    config.lookbook.live_updates = false
    config.lookbook.preview_embeds.enabled = false
  end
end

AtomicDesign::Application.initialize!

AtomicDesign::Application.routes.draw do
  mount Lookbook::Engine, at: '/'
end

run(
  app: AtomicDesign::Application,
  Host: '0.0.0.0',
  Port: 8080
)
