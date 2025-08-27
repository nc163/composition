#!/bin/ruby

require 'bundler/setup'

require 'dotenv/load'
require 'puma'
require 'rails'
require 'active_support'
require 'active_support/core_ext'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'action_view/testing/resolvers'

require 'lookbook'
require 'atomic_design/engine'
require_relative 'preview/atomic_design/modules/preview'

ENV['RACK_ENV'] = 'deployment'
ENV['RAILS_ENV'] = 'development'

# Lookbook
module PreviewApp
  # プレビュー用のRailsアプリケーション
  class Application < Rails::Application
    # rails
    config.load_defaults 7.0
    config.root = __dir__
    config.enable_reloading = true
    config.file_watcher = ActiveSupport::EventedFileUpdateChecker
    # プレビューでは eager_load は不要だけど、Rails対応に必要
    config.eager_load = false
    config.autoload_paths += Dir[
      Rails.root.join('lib'),
      Rails.root.join('preview')
    ]
    config.autoload_once_paths -= Dir[Rails.root.join('preview')]
    # form で必要な CSRF トークンを生成に必要,もしくは `form_with(authenticity_token: false)`
    config.secret_key_base = 'demo_secret_key_base_'
    config.logger = Logger.new($stdout)
    config.log_level = :warn

    # rack
    config.middleware.use Rack::Static, urls: ['/assets/fonts'],
                                        root: File.expand_path('lib/atomic_design', __dir__)
    config.middleware.use Rack::Static, urls: ['/assets/javascripts'],
                                        root: File.expand_path('lib/atomic_design', __dir__)
    config.middleware.use Rack::Static, urls: ['/assets/stylesheets'],
                                        root: File.expand_path('lib/atomic_design', __dir__)
    config.middleware.use Rack::Static, urls: ['/assets/images'],
                                        root: File.expand_path('preview/atomic_design', __dir__)

    # lookbook
    config.lookbook.project_name = "Atomic Design #{AtomicDesign::Version.gem_version}"
    config.lookbook.preview_layout = 'default'
    config.lookbook.preview_display_options = {
      theme: %w[light dark],
      resizable: false
    }
    config.lookbook.project_logo = false
    config.lookbook.ui_favicon = false
    config.lookbook.reload_on_change = true
    config.lookbook.live_updates = false
    # preview
    config.lookbook.preview_inspector.enabled = true
    config.lookbook.preview_inspector.sidebar_panels = %i[previews pages]
    config.lookbook.preview_inspector.drawer_panels = %i[source params]
    config.lookbook.preview_params_options = {
      enabled: true,
      viewport: {
        resizable: false,
        width: '100%'
      }
    }
    config.lookbook.preview_collection_label = 'Previews'
    config.lookbook.preview_paths = [File.expand_path('preview/', __dir__)]
    config.lookbook.page_collection_label = 'Documents'
    config.lookbook.page_paths = [File.expand_path('docs/', __dir__)]
    config.lookbook.page_route = 'docs'

    initializer 'preview.setup_helpers', before: :load_config_initializers do |app|
      ActiveSupport.on_load(:action_controller_base) do
        include AtomicDesign::Helpers
      end
    end

    initializer 'preview.create_layout', after: :load_config_initializers do |_app|
      layout_erb = <<~'ERB'
        <!DOCTYPE html>
        <html lang="ja" style='height: 100%;'>
          <head>
            <meta charset="utf-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
            <link rel="stylesheet" href="/assets/stylesheets/fontawesome-free-7.0.0_all.min.css">
            <link rel="stylesheet" href="/assets/stylesheets/bootstrap_5_3_0.min.css">
            <link rel="stylesheet" href="/assets/fonts/bootstrap-icons_1_13_1.min.css">
          </head>
          <body >
            <div class="container-xl">
              <%= yield %>
            </div>
            <script src="/assets/javascripts/fontawesome-free-7.0.0_all.min.js"></script>
            <script src="/assets/javascripts/bootstrap_5_3_0.min.js"></script>
          </body>
        </html>
      ERB

      config.to_prepare do
        resolver = ActionView::FixtureResolver.new('layouts/default.html.erb' => layout_erb)
        unless ActionController::Base.view_paths.include?(resolver)
          ActionController::Base.prepend_view_path(resolver)
        end

        PreviewApp::Application.routes_reloader.execute_if_updated
        PreviewApp::Application.routes.draw do
          # root to: redirect('/preview')
          # mount ::Lookbook::Engine, at: 'preview'
          mount ::Lookbook::Engine, at: '/'
        end
      end
    end
  end
end

PreviewApp::Application.initialize!

PreviewApp::Application.routes.draw do
  # root to: redirect('/preview')
  # mount ::Lookbook::Engine, at: 'preview'
  mount ::Lookbook::Engine, at: '/'
end

run(PreviewApp::Application)
