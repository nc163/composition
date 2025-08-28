require 'lookbook'
# require 'atomic_design'

Lookbook.configure do |config|
  config.project_name = "Atomic Design #{AtomicDesign::Version.gem_version}"
  config.project_logo = false
  config.ui_favicon = false
  config.reload_on_change = true
  config.live_updates = false
end
