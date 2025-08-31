# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Helpers
      module PropertyHelpers
        # プロパティ
        class Property < ::Hash
          PASSIVE = :passive
          EFFECTIVE = :effective

          METHOD = :method
          HTML_ATTRS = :html_attrs

          def initialize(required: false, default: nil, **options)
            super
            self[:required] = required
            self[:default] = default
            self[:options] = options

            self[:set] = default
          end

          def options
            self[:options]
          end

          def function
            raise NotImplementedError
          end

          def default
            self[:default]
          end

          def required?
            self[:required]
          end

          def get(value = nil)
            { value: get_value(value || default), type: type }
          end

          protected

          def get_value(value)
            raise NotImplementedError
          end

          def allow_options?(**options)
            raise NotImplementedError
          end
        end
      end
    end
  end
end
