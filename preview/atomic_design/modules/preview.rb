# frozen_string_literal: true

module AtomicDesign
  module Modules
    class Preview < Lookbook::Preview # :nodoc:
      include ViewComponent::PreviewActions
      include AtomicDesign::Helpers
    end
  end
end
