# frozen_string_literal: true

module FunctionalView
  module Property
    class FunctionBuilder # :nodoc:
      #
      def self.build(spec, user_property = nil)
        case spec.type
        when :state
          State.new(**build_options(spec, user_property))
        when :context
          Context.new(**build_options(spec, user_property))
        end
      end

      private

      def self.build_options(spec, user_property)
        options = {}
        (Functions::Action::REQUIRED_OPTIONS + Functions::Action::ALLOW_OPTIONS).each do |attr|
          options[attr] = spec.send(attr) if spec.respond_to?(attr)
        end
        options[:params] = user_property
        options
      end
    end
  end
end
