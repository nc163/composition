# frozen_string_literal: true

module FunctionalView
  module Modules
    class Context < Function # :nodoc:
      def call
        argv.map { |v| params[v] }
      end
    end
  end
end
