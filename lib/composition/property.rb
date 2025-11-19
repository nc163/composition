# frozen_string_literal: true

module Composition
  class Property # :nodoc:
    REQUIRED_KEYS = [ :name, :params, :required, :default, :to ].freeze
    attr_accessor(*REQUIRED_KEYS)

    def initialize(**kwargs)
      options = default_kwargs.merge(kwargs)
      missing_keys = required_keys - options.keys
      raise ArgumentError, "missing options: #{missing_keys.join(', ')}" unless missing_keys.empty?

      required_keys.each do |k|
        send("#{k}=", options[k])
      end
    end

    #
    def type
      raise NotImplementedError, "You must implement #{self.class}##{__method__}"
    end

    def required?
      !!@required
    end

    def action(val = nil)
      function(val || @default)
    end

    def close
      clone_options = {}
      self.class.new(**clone_options)
    end

    protected

    def required_keys
      REQUIRED_KEYS
    end

    def function(val = nil)
      raise NotImplementedError, "You must implement #{self.class}##{__method__}"
    end

    def default_kwargs
      {
        params: nil,
        required: false,
        default: nil,
        to: nil
      }
    end
  end
end
