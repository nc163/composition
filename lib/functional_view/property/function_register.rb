# frozen_string_literal: true

require "forwardable"
require "active_support/core_ext/object/deep_dup"

module FunctionalView
  module Property
    class FunctionRegister # :nodoc:
      attr_accessor :functions

      def initialize
        @functions = {}
      end

      def all
        functions.values
      end

      # def list
      #   functions.keys
      # end

      def add(function)
        # raise ArgumentError, "Invalid function" unless function.is_a?(Functional::Functions::Definition)

        functions[function.name] = function
      end

      def find(name)
        @functions[name.to_sym]
      end

      # def resolve(name, value = nil)
      #   function = functions[name]
      #   raise ArgumentError, "Function not found: #{name}" unless function

      #   function.call(value)
      # end

      def pluck(attribute)
        functions.map { |function| function.send(attribute) }
      end

      def select_method(f)
        self.class.new.tap do |register|
          functions.select { |_, func| func.to == f }.each { |_, func| register.add(func) }
        end
      end

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

      # def requireds
      #   select(&:required?)
      # end

      def clone
        self.class.new.tap do |clone|
          clone.instance_variable_set(:@functions, @functions.deep_dup)
        end
      end
    end
  end
end
