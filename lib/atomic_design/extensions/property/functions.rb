# frozen_string_literal: true

module AtomicDesign
  module Extensions
    module Property
      module Functions
        METHOD = :method
        HTML_ATTRS = :html_attrs
        # RECIPIENTS = :to

        extend ActiveSupport::Autoload

        eager_autoload do
          # Class
          autoload :Effect
          autoload :State
        end

        # プロパティ機能の基底クラス
        class Base < ::Hash
          def initialize(to: nil, required: false, default: nil, **options)
            self[:to] = to
            self[:required] = required
            self[:default] = default
          end

          def to
            self[:to]
          end

          def required?
            !!self[:required]
          end

          def call(value)
            resolve(value || self[:default])
          end

          protected

          def resolve(value)
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
