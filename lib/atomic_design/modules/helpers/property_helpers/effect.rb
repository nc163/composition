
# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Helpers
      module PropertyHelpers
        class Effect < Property # :nodoc:
          def function
            HTML_ATTRS
          end

          def get_value(value)
            options[:to].is_a?(Proc) ? options[:to].call(value) :
              options[:to].is_a?(Hash) ? options[:to][value] : raise
          end

          protected

          def allow_options?(**options)
            options[:map].is_a?(Hash) || options[:to].is_a?(Proc)
          end
        end
      end
    end
  end
end
