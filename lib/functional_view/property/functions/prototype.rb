# frozen_string_literal: true

module FunctionalView
  module Property
    module Functions
      class Prototype # :nodoc:
        REQUIRED_OPTIONS = [ :name, :type, :argv, :to ].freeze
        attr_accessor(*REQUIRED_OPTIONS)

        def initialize(**kwargs)
          options = default_options.merge(kwargs)

          missing_keys = REQUIRED_OPTIONS - options.keys
          raise ArgumentError, "missing options: #{missing_keys.join(', ')}" unless missing_keys.empty?

          options.each do |k, v|
            send("#{k}=", v) if respond_to?("#{k}=")
          end
        end

        def required_keys
          Prototype::REQUIRED_OPTIONS
        end

        def default_options
          {}
        end
      end
    end
  end
end
