# frozen_string_literal: true

require "forwardable"
require "active_support/core_ext/object/deep_dup"

module FunctionalView
  class PropertyResolver < Property # :nodoc:
    def any?
      functions.any?
    end

    def none?
      functions.none?
    end

    def append(function)
      raise ArgumentError, "Function must have a name" unless function.is_a?(Function)

      functions[function.name] = function
    end

    def count
      functions.size
    end

    # def select(k = nil, v = nil, &block)
    #   if block_given?
    #     filtered_functions = functions.values.select(&block)
    #   elsif k && v
    #     filtered_functions = functions.values.select { |function| function.send(k) == v }
    #   else
    #     raise ArgumentError, "Either provide k, v parameters or a block"
    #   end

    #   # 新しいFunctionRegisterインスタンスを作成してチェーンメソッドに対応
    #   self.class.new.tap do |register|
    #     filtered_functions.each { |func| register.append(func) }
    #   end
    # end

    def pluck(attribute)
      functions.values.map { |f| f.send(attribute.to_sym) }
    end

    def find(name)
      functions[name.to_sym]
    end

    # def collect(&block)
    #   functions.collect(&block)
    # end

    # def detect(&block)
    #   functions.detect(&block)
    # end

    def select(&block)
      self.class.new.tap do |property|
        functions.each_value { |func| property.append(func) if block.call(func) }
      end
    end

    def map(&block)
      self.class.new.tap do |property|
        functions.each_value { |func| property.append(block.call(func)) }
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

    private

    def each(&block)
      functions.each(&block)
    end
  end


  # #
  # class Resolver # :nodoc:
  #   extend Forwardable
  #   attr_accessor :function_register, :user_property, :actions
  #
  #   def initialize(function_spec_register, user_property = {})
  #     @function_register = function_spec_register
  #     @user_property = user_property
  #     @actions = {}
  #     function_register.functions.transform_values do |function|
  #       # actions[function.name] = Builder.build(function, user_property)
  #       actions[function.name] = function.clone
  #     end
  #   end
  #
  #   def action_resolve(action_type, action_name)
  #     action = actions[action_name]
  #     action.call
  #   end
  #
  #   def access_resolve(access_name)
  #     actions.select { |_, action| action.to == access_name }
  #            .map { |_, action| action.call }
  #   end
  #
  #   def user_property
  #     user_property
  #   end
  #
  #   def without_user_property
  #     required_property_names = {}
  #     function_register.functions.each do |name, spec|
  #       required_property_names[name] = spec.required_properties
  #     end
  #   end
  # end
end
