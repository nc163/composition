# frozen_string_literal: true

module AtomicDesign
  module Extensions
    module Property
      module Helpers
        module FunctionHelpers
          module StateHelper # :nodoc:
            extend ActiveSupport::Concern

            module ClassMethods # :nodoc:
              # state :title
              # ...
              # self.title
              # # => "タイトル"
              # state :size, from: SIZE_MAP
              def state(name, **options)
                # raise ArgumentError, "Invalid state options" unless allow_state_options?(**options)

                def_property(name, Property::Functions::State.new(**options))
              end

              protected

              def allow_options?(**options)
                true # (options.keys - ALLOW_STATE_OPTION_KEYS).empty?
              end
            end

            protected

            # 状態を返す
            def state(name)
              property[name][:value]
            end
          end
        end
      end
    end
  end
end
