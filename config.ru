#!/usr/bin/env ruby

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
module ComponentDemo
  class Application < Rails::Application
    config.load_defaults 7.0
    config.root = __dir__
    config.eager_load = false

    config.secret_key_base = 'demo_secret_key_base_'
    config.session_store :cookie_store, key: '_component_demo_session'
    config.logger = Logger.new(STDOUT)
    config.log_level = :info

    config.web_console.allowed_ips = '0.0.0.0/0'

    # Lookbookの設定
    if defined?(Lookbook)
      config.autoload_paths += Dir[ Rails.root.join('previews') ]
      config.view_component.preview_paths = [ File.expand_path('previews', __dir__) ]

      # https://lookbook.build/guide/config
      # config.view_component.default_preview_layout = "component_preview"
      config.lookbook.project_name = "AtomicDesign Preview"
      config.lookbook.preview_collection_label = "Components"
      config.lookbook.project_logo = false
      config.lookbook.ui_favicon = false
      config.lookbook.reload_on_change = false
      config.lookbook.live_updates = false
      config.lookbook.preview_embeds.enabled = false
    end
  end
end

puts "🚀 Initializing Rails application..."
puts "📚 Lookbook preview_path #{File.expand_path('previews/atomic_design/component', __dir__)}"

ComponentDemo::Application.initialize!

ComponentDemo::Application.routes.draw do
  root 'demo#index'

  # Lookbookが利用可能な場合のみマウント
  if defined?(Lookbook)
    mount Lookbook::Engine, at: '/lookbook'
  end
end

class DemoController < ActionController::Base
  def index
    binding.console
    render html: demo_html.html_safe
  end

  private

  def demo_html
    <<~HTML
      <!DOCTYPE html>
      <html>
        <head>
          <title>Component Library Demo</title>
          <meta charset="utf-8">
          <meta name="viewport" content="width=device-width, initial-scale=1">
          <style>
            #{default_button_css}
          </style>
        </head>
        <body style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; padding: 2rem; background: #f8f9fa;">
          <div style="max-width: 800px; margin: 0 auto;">
            <h1 style="color: #2d3748; margin-bottom: 2rem;">Rails UI Component Demo</h1>

            <div style="background: white; padding: 2rem; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); margin-bottom: 2rem;">
              <h2 style="color: #4a5568; margin-bottom: 1rem;">Button Variants</h2>
              <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
                #{render_simple_buttons}
              </div>
            </div>

            <div style="margin-top: 2rem; padding: 1rem; background: #e8f4fd; border-radius: 8px;">
              <h3 style="margin: 0 0 1rem 0; color: #1e40af;">Debug Info</h3>
              <ul style="margin: 0; padding-left: 1.5rem;">
                <li>Rails Application Class: #{Rails.application.class}</li>
                <li>Module Parent: #{Rails.application.class.module_parent_name rescue 'nil'}</li>
                <li>ViewComponent: #{defined?(ViewComponent) ? '✅' : '❌'}</li>
                <li>Lookbook: #{defined?(Lookbook) ? '✅' : '❌'}</li>
              </ul>
              #{lookbook_link}
            </div>
          </div>
        </body>
      </html>
    HTML
  end

  def render_simple_buttons
    [
      '<button class="component-button component-button--primary component-button--medium">Primary</button>',
      '<button class="component-button component-button--secondary component-button--medium">Secondary</button>',
      '<button class="component-button component-button--danger component-button--medium">Danger</button>',
      '<button class="component-button component-button--success component-button--medium">Success</button>'
    ].join("\n")
  end

  def default_button_css
    <<~CSS
      .component-button {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        border-radius: 0.375rem;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.2s ease-in-out;
        border: 1px solid transparent;
        font-family: inherit;
        line-height: 1.5;
      }
      .component-button:focus { outline: 2px solid #3b82f6; outline-offset: 2px; }
      .component-button--primary {
        background-color: #3b82f6;
        color: white;
        border-color: #3b82f6;
      }
      .component-button--primary:hover {
        background-color: #2563eb;
        border-color: #2563eb;
      }
      .component-button--secondary {
        background-color: #6b7280;
        color: white;
        border-color: #6b7280;
      }
      .component-button--secondary:hover {
        background-color: #4b5563;
        border-color: #4b5563;
      }
      .component-button--danger {
        background-color: #ef4444;
        color: white;
        border-color: #ef4444;
      }
      .component-button--danger:hover {
        background-color: #dc2626;
        border-color: #dc2626;
      }
      .component-button--success {
        background-color: #10b981;
        color: white;
        border-color: #10b981;
      }
      .component-button--success:hover {
        background-color: #059669;
        border-color: #059669;
      }
      .component-button--small {
        padding: 0.375rem 0.75rem;
        font-size: 0.875rem;
      }
      .component-button--medium {
        padding: 0.5rem 1rem;
        font-size: 1rem;
      }
      .component-button--large {
        padding: 0.75rem 1.5rem;
        font-size: 1.125rem;
      }
    CSS
  end

  def lookbook_link
    if defined?(Lookbook)
      '<p style="margin-top: 1rem;"><a href="/lookbook" style="color: #3b82f6; text-decoration: none;">📚 Lookbook Preview →</a></p>'
    else
      '<p style="margin-top: 1rem; color: #6b7280;">💡 Lookbook not available</p>'
    end
  end
end

run ComponentDemo::Application
