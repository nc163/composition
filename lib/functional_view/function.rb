# frozen_string_literal: true

module FunctionalView
  class Function # :nodoc:
    REQUIRED_KEYS = [ :type, :name, :argv, :required, :default, :to ].freeze
    attr_accessor(*REQUIRED_KEYS)
    attr_accessor :value

    def initialize(**kwargs)
      options = default_options.merge(kwargs)

      missing_keys = REQUIRED_KEYS - options.keys
      raise ArgumentError, "missing options: #{missing_keys.join(', ')}" unless missing_keys.empty?

      options.each do |k, v|
        send("#{k}=", v) if respond_to?("#{k}=")
      end
    end

    def required?
      !!self.required
    end

    def required_keys
      REQUIRED_KEYS
    end

    def call
      raise NotImplementedError, "You must implement #{self.class}##{__method__}"
    end

    def close
      clone_options = {}
      self.class.new(**clone_options)
    end

    private

    def default_options
      {}
    end
  end
end
