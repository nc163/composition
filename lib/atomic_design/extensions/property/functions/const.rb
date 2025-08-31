# frozen_string_literal: true

module AtomicDesign
  module Extensions
    module Property
      module Functions
        class Const < Base # :nodoc:
          def initialize(value: nil, **options)
            super(**options)

            self[:value] = value
          end


          protected

          def resolve(value)
            # options[:to].is_a?(Proc) ? options[:to].call(value) :
            #   options[:to].is_a?(Hash) ? options[:to][value] : raise
            value
          end

          # def allow_options?(**options)
          #   options[:proc].is_a?(Proc)
          # end
        end
      end
    end
  end
end
