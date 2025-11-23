# frozen_string_literal: true

require "forwardable"
require "active_support/core_ext/object/deep_dup"

module Composition
  class PropertySet
    include Enumerable

    attr_reader :functions

    def initialize
      @functions = {}
    end

    def each(&block)
      functions.each_value(&block)
    end

    def any?
      functions.any?
    end

    def none?
      functions.none?
    end

    def append(property)
      raise ArgumentError, "Property must have a name" unless property.is_a?(Property)

      functions[property.name] = property
    end

    def count
      functions.size
    end

    def pluck(attribute)
      functions.values.map { |f| f.send(attribute) }
    end

    def find(name)
      functions[name.to_sym]
    end

    def select(&block)
      self.class.new.tap do |property|
        functions.each_value { |func| property.append(func) if block.call(func) }
      end
    end

    #
    #   def without_user_property()
    #     without_property = {}
    #     functions.each do |name, f|
    #       without_property[name] = f
    #     end
    #   end

    def clone
      self.class.new.tap do |clone|
        clone.instance_variable_set(:@functions, @functions.deep_dup)
      end
    end
  end
end
