# frozen_string_literal: true

require "forwardable"
require "active_support/core_ext/object/deep_dup"

module AtomicDesign
  module Extensions
    module Property
      #
      class Dispacher
        #
        def dispatch(result)
          case result
          in { to:, value: }
            case to
            when :html
              @html_options ||= []
              @html_options << value
            end
          end
        end

        private

        # 色々なHTML属性のマージを頑張る
        def merge_html_attributes(key, old_value, new_value)
          raise ArgumentError, "Key must be a Symbol" unless key.is_a?(Symbol)

          case key
          when :id, :class
            [ old_value, new_value ].compact.join(" ")
          when :style
            [ old_value, new_value ].compact.join("; ")
          when :data, :arel
            old_value.to_h.merge(new_value.to_h)
          else
            [ old_value, new_value ].compact.join(" ")
          end
        end
      end
    end
  end
end
