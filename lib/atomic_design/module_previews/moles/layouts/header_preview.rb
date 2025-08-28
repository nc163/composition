# frozen_string_literal: true

module AtomicDesign
  module ModulePreviews
    module Moles
      module Layouts
        class HeaderPreview < Base # :nodoc:
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
