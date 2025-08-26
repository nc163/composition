# frozen_string_literal: true

module AtomicDesign
  module Modules
    class Preview < ::Lookbook::Preview # :nodoc:
      # include ::ViewComponent::PreviewActions
      include ::AtomicDesign::Helpers

      def self.prepend_view_path(path)
        ActionController::Base.prepend_view_path(path)
      end
    end
  end
end
