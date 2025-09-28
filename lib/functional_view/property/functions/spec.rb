# frozen_string_literal: true

module FunctionalView
  module Property
    module Functions
      class Spec < Prototype
        ALLOW_OPTIONS = [ :required, :default ].freeze
        attr_accessor(*ALLOW_OPTIONS)

        def default_options
          { required: false, default: nil }
        end

        def required?
          !!self.required
        end
      end
    end
  end
end
