# frozen_string_literal: true

require "forwardable"
require "active_support/core_ext/object/deep_dup"

module Composition
  class Resolver # :nodoc:
    extend Forwardable
    attr_accessor :property_set, :user_property, :actions

    def initialize(property_set, user_property = {})
      @property_set = property_set
      @user_property = user_property
      @actions = {}
      property_set.functions.transform_values do |function|
        actions[function.name] = function.clone
      end
    end

    def action_resolve(action_name)
      user_params = user_property[action_name]
      property_set.find(action_name).action(user_params)
    end

    def access_resolve(property_access_name)
      actions.select { |_, action| action.to == property_access_name }
            .map { |_, action|
              user_params = user_property[action.name]
              action.action(user_params)
            }
    end

    # user_propertyからproperty_setに定義されているキー以外を返す
    def without_property
      property_names = property_set.functions.keys
      user_property.reject { |key, _| property_names.include?(key) }
    end

    private
  end
end
