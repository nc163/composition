# frozen_string_literal: true

require "forwardable"
require "active_support/core_ext/object/deep_dup"

module FunctionalView
  module Property
    class FunctionResolver # :nodoc:
      extend Forwardable
      attr_accessor :function_register, :actions

      def initialize(function_spec_register, user_property = {})
        @function_register = function_spec_register
        @actions = {}
        function_register.functions.transform_values do |spec|
          actions[spec.name] = FunctionBuilder.build(spec, user_property)
        end
      end

      def without(**args)
        actions.reject! { |name, _| args.key?(name) }
        {}
      end

      def action_resolve(action_type, action_name)
        action = actions[action_name]
        case action_type
        when :state
        when :context
          action.call
        end
      end

      def access_resolve(access_name)
        actions.select { |_, action| action.to == access_name }
               .map { |_, action| action.call }
      end

      private

      # #
      # def state_resolve(state)
      #   # @function_actions[state_name] ||= function_resolve(function_spec_register.find(state_name))
      #   return user_property[state.name] if state.argv.nil?

      #   case state.argv.class.name
      #   when "Proc"
      #     state.argv.call(user_property[state.name])
      #   when "Hash"
      #     if user_property[state.name].nil?
      #       state.argv
      #     else
      #       state.argv[user_property[state.name].to_sym]
      #     end
      #   else
      #     raise ArgumentError, "Invalid argv type: #{state.argv.class}"
      #   end
      # end

      # def context_resolve(context_name)
      #   # @function_actions[context_name] ||= function_resolve(function_spec_register.find(context_name))
      # end

      # def call(value = nil)
      #   return value if argv.nil?
      #   case argv.class.name
      #   when "Proc"
      #     argv.call(value)
      #   when "Hash"
      #     if value.nil?
      #       argv
      #     else
      #       argv[value.to_sym]
      #     end
      #   else
      #     raise ArgumentError, "Invalid argv type: #{argv.class}"
      #   end
      # end
    end
  end
end
