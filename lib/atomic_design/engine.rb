# frozen_string_literal: true

require "rails/engine"
require "atomic_design"
require "view_component"

#
module AtomicDesign
  class Engine < Rails::Engine
    isolate_namespace AtomicDesign

    config.eager_load_namespaces << AtomicDesign

    # :nocov:
    initializer "atomic_design.set_configs", before: :set_autoload_paths do |app|
      lib_path = root.join("lib")
      unless app.config.autoload_paths.include?(lib_path)
        app.config.autoload_paths += Dir[ lib_path ]
      end
     end

    #
    initializer "atomic_design.check_view_component", before: "view_component.set_configs" do |app|
      # ViewComponentが利用可能であることを確認
      # https://github.com/ViewComponent/view_component/blob/main/lib/view_component/engine.rb#L29C33-L29C44
      unless defined?(ViewComponent)
        raise "ViewComponent is required for Component gem. Please add 'view_component' to your Gemfile."
      end
      app.config.view_component.view_component_path = root.join("lib", "design", "component").to_s
      app.config.view_component.capture_compatibility_patch_enabled = true
     end

    # # :nocov:
    # # プレビューパスの設定
    # initializer "atomic_design.configure_lookbook", after: "view_component.set_configs" do |app|
    #   if defined?(Lookbook) && Rails.env.development?
    #     # Lookbookのプレビューパスにコンポーネントのプレビューディレクトリを追加
    #     preview_paths = Array(ViewComponent::Base.preview_paths)
    #     component_preview_path = root.join("previews").to_s
    #     preview_paths << component_preview_path unless preview_paths.include?(component_preview_path)
    #     ViewComponent::Base.preview_paths = preview_paths
    #   end
    # end

    # :nocov:
    # アセットの設定
    # initializer "atomic_design.assets" do |app|
    #   if app.config.respond_to?(:assets)
    #     app.config.assets.paths << root.join("lib", "assets", "stylesheets")
    #     app.config.assets.paths << root.join("lib", "assets", "javascripts")
    #   end
    # end
  end
end
