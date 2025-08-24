# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      class Dummy < ::AtomicDesign::Modules::Base # :nodoc:
        attrs id: 'dummy-1', class: 'dummy'

        def context
          contexts[0]
        end
      end
    end
  end
end
