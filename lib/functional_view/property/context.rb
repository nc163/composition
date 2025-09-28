# frozen_string_literal: true

#
require "active_support/concern"

module FunctionalView # :nodoc:
  module Property
    class Context < Functions::Action
      def call
        argv.map { |v| params[v] }
      end
    end
  end
end
