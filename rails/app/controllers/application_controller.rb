class ApplicationController < ActionController::Base
  include AtomicDesign::Helpers
  
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
end
