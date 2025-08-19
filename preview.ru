#!/bin/ruby

require 'bundler/setup'

require 'webrick'
require 'rails'
require 'active_support'
require 'active_support/core_ext'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'action_view/testing/resolvers'

require 'web_console'
require 'view_component'
require 'lookbook'
require 'atomic_design/engine'

module Preview # :nodoc:
  # プレビュー用のRailsアプリケーション
  class Application < Rails::Application
    config.load_defaults 7.0
    config.root = __dir__
    # プレビューでは eager_load は不要だけど、対応は必要
    config.eager_load = false
    # /assets で始まるURLを lib/assets から配信する
    config.middleware.use Rack::Static, urls: ['/assets'], root: File.expand_path('lib/atomic_design', __dir__)
    config.secret_key_base = 'demo_secret_key_base_'
    config.session_store :cookie_store, key: '_component_demo_session'
    config.logger = Logger.new($stdout)
    config.log_level = :info

    # web console
    config.web_console.allowed_ips = '0.0.0.0/0'

    # lookbook
    # view_component 3系では必要 rb と erb の紐付け. 4系では不要
    config.view_component.preview_paths = [File.expand_path('lib', __dir__)]
    config.autoload_paths += Dir[Rails.root.join('lib')]
    config.lookbook.project_name = 'AtomicDesign'
    config.lookbook.preview_collection_label = 'Components'
    config.lookbook.preview_layout = 'preview_layout'
    config.lookbook.preview_display_options = {
      theme: %w[light dark]
    }
    config.lookbook.project_logo = false
    config.lookbook.ui_favicon = false
    config.lookbook.reload_on_change = true
    config.lookbook.live_updates = false
    config.lookbook.preview_embeds.enabled = false

    initializer 'preview.layout' do |_app|
      layout_erb = <<~'ERB'
        <!DOCTYPE html>
        <html>
          <head>
            <meta charset="utf-8">
            <link rel="stylesheet" href="/assets/stylesheets/bootstrap.min.css">
          </head>
          <body>
            <script src="/assets/javascripts/bootstrap.min.js"></script>
            <%= yield %>
          </body>
        </html>
      ERB
      resolver = ActionView::FixtureResolver.new(
        'layouts/preview_layout.html.erb' => layout_erb
      )
      ActiveSupport.on_load(:action_controller) do
        prepend_view_path resolver
      end
    end

    Preview::Application.initialize!

    Preview::Application.routes.draw do
      mount Lookbook::Engine, at: '/'
    end
  end
end

run(Preview::Application)
