# frozen_string_literal: true

require "active_support/concern"

module FunctionalView # :nodoc:
  module Property
    class State < Functions::Action
      def call
        case argv.class.name
        when "Proc"
          argv.call(params[name])
        when "Hash"
          if params[name].nil?
            argv
          else
            argv[params[name].to_sym]
          end
        else
          raise ArgumentError, "Invalid argv type: #{argv.class}"
        end
      end
    end
  end
end
