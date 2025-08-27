# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Moles
      module Layouts
        class HeaderPreview < ::AtomicDesign::Modules::Preview # :nodoc:
          # @!group default

          def content
            render atomic_design.moles.layouts.header
          end

          # @!endgroup
        end
      end
    end
  end
end
