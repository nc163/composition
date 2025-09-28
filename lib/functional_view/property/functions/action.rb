# frozen_string_literal: true

module FunctionalView # :nodoc:
  module Property
    module Functions
      class Action < Prototype
        ALLOW_OPTIONS = [ :value, :params ].freeze
        attr_accessor(*ALLOW_OPTIONS)

        def default_options
          { argv: nil, value: nil, params: nil }
        end

        def call
          raise
        end
      end
    end
  end
end
