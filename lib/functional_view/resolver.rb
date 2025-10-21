# frozen_string_literal: true

require "forwardable"
require "active_support/core_ext/object/deep_dup"

module FunctionalView
  class Resolver # :nodoc:
    extend Forwardable
    attr_accessor :function_register, :user_property, :actions

    def initialize(property_set, user_property = {})
      @property_set = property_set
      @user_property = user_property
      @actions = {}
      property_set.functions.transform_values do |function|
        actions[function.name] = function.clone
      end
    end

    def action_resolve(action_type, action_name)
      action = actions[action_name]
      action.action
    end

    def access_resolve(access_name)
      actions.select { |_, action| action.to == access_name }
             .map { |_, action| action.action }
    end

    def user_property
      user_property
    end

    def without_user_property
      required_property_names = {}
      property_set.functions.each do |name, spec|
        required_property_names[name] = spec.required_properties
      end
    end
  end
end
