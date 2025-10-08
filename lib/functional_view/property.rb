# frozen_string_literal: true

require "forwardable"
require "active_support/core_ext/object/deep_dup"

module FunctionalView
  class Property
    include Enumerable
    attr_reader :functions
    # attr_accessor :functions

    def initialize
      @functions = {}
    end

    # def all
    #   functions.values
    # end

    def add(function)
      # raise ArgumentError, "Invalid function" unless function.is_a?(Functional::Functions::Definition)

      functions[function.name] = function
    end

    # def find(name)
    #   @functions[name.to_sym]
    # end

    def pluck(attribute)
      functions.map { |function| function.send(attribute) }
    end

    # def select_method(f)
    #   self.class.new.tap do |register|
    #     functions.select { |_, func| func.to == f }.each { |_, func| register.add(func) }
    #   end
    # end

    def select(k = nil, v = nil, &block)
      if block_given?
        filtered_functions = functions.values.select(&block)
      elsif k && v
        filtered_functions = functions.values.select { |function| function.send(k) == v }
      else
        raise ArgumentError, "Either provide k, v parameters or a block"
      end

      # 新しいFunctionRegisterインスタンスを作成してチェーンメソッドに対応
      self.class.new.tap do |register|
        filtered_functions.each { |func| register.add(func) }
      end
    end

    def clone
      self.class.new.tap do |clone|
        clone.instance_variable_set(:@functions, @functions.deep_dup)
      end
    end


    private
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
