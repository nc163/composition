# frozen_string_literal: true

require 'rails/engine'
require 'atomic_design'
require 'view_component'

module AtomicDesign
  class Engine < Rails::Engine # :nodoc:
    isolate_namespace AtomicDesign

    config.eager_load_namespaces << AtomicDesign
    config.paths.add 'lib', eager_load: true

    # :nocov:
    # initializer 'atomic_design.set_configs', before: :set_autoload_paths do |app|
    #   lib_path = root.join('lib')
    #   app.config.autoload_paths += Dir[lib_path] unless app.config.autoload_paths.include?(lib_path)
    # end

    #
    initializer 'atomic_design.check_view_component', before: 'view_component.set_configs' do |app|
      if Gem.loaded_specs['view_component'].version < Gem::Version.new('4.0.0')
        app.config.view_component.view_component_path = root.join('lib', 'atomic_design', 'components').to_s
        app.config.view_component.capture_compatibility_patch_enabled = true
      end
    end

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
