# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class DummyPreview < ::ViewComponent::Preview # :nodoc:
        # @!group default

        # @param context
        def default(context = 'Example')
          render Dummy.new(context)
        end
      end
    end
  end
end
