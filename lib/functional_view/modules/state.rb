# frozen_string_literal: true

module FunctionalView
  module Modules
    class State < Function # :nodoc:
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
