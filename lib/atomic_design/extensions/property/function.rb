# frozen_string_literal: true

module AtomicDesign
  module Extensions
    module Property
      # プロパティ機能の基底クラス
      class Function < ::Hash
        ALLOW_OPTIONS = [ :to, :required, :default ]

        def initialize(*args, **kwargs)
          invalid_keys = kwargs.keys - allowed_options
          raise ArgumentError, "Invalid option(s): #{invalid_keys.join(', ')}" unless invalid_keys.empty?

          super(**kwargs)
        end

        def to
          self[:to] || :value
        end

        def required?
          self[:required] || false
        end

        def default
          self[:default]
        end

        def call(value)
          send_value = value || default
          if required? && send_value.nil?
            raise ArgumentError, "Missing required property: #{self[:name]}"
          end

          resolve(send_value)
        end

        protected

        def resolve(value)
          raise NotImplementedError
        end

        def allow_options
          raise NotImplementedError
        end

        private

        def allowed_options
          ALLOW_OPTIONS + allow_options
        end
      end
    end
  end
end
