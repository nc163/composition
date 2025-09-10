# frozen_string_literal: true

require "forwardable"
require "active_support/core_ext/object/deep_dup"

module Property
  #
  class Register
    def initialize
      @functions = {}
    end

    def all
      @functions.values
    end

    def list
      @functions.keys
    end

    def add(function)
      raise ArgumentError, "Invalid function" unless function.is_a?(Property::Function)

      @functions[function.name] = function
    end

    def exist?(name)
      @functions.key?(name)
    end

    def find(name)
      @functions[name]
    end

    def clone
      self.class.new.tap do |clone|
        clone.instance_variable_set(:@functions, @functions.deep_dup)
      end
    end
  end
end
