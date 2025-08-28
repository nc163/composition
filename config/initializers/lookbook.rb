require 'lookbook'

Lookbook.configure do |config|
  config.project_name = "Atomic Design #{AtomicDesign::Version.gem_version} Preview"
  config.preview_layout = 'default'
  config.preview_display_options = {
    theme: %w[light dark],
    resizable: false
  }
  config.project_logo = false
  config.ui_favicon = false
  config.reload_on_change = true
  config.live_updates = false

  config.preview_inspector.enabled = true
  config.preview_inspector.sidebar_panels = %i[previews pages]
  config.preview_inspector.drawer_panels = %i[source params]
  config.preview_params_options = {
    enabled: true,
    viewport: {
      resizable: false,
      width: '100%'
    }
  }
  config.preview_collection_label = 'Previews'
  config.preview_paths = [
    Rails.root.join('lib/atomic_design/module_previews')
  ]
  config.page_collection_label = 'Documents'
  config.page_paths = [
    Rails.root.join('lib/atomic_design/documents')
  ]
  config.page_route = 'docs'
end
