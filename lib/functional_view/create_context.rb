# frozen_string_literal: true

module FunctionalView # :nodoc:
  module CreateContext
    extend ActiveSupport::Concern

    #
    class Context < Function
      def call
        argv.map { |v| params[v] }
      end
    end

    module ClassMethods # :nodoc:
      # 状態管理を移譲する
      # renders_one :head, HeaderComponent
      # renders_one :foot, FooterComponent
      # context :head, [ :title ]
      # context :foot, [ :note ]
      def context(name, argv = nil, default: nil, required: false)
        function = Context.new(
          type: :context,
          name: name.to_sym,
          argv: argv,
          to: nil,
          default: default,
          required: required
        )
        def_function(function)
      end
    end
  end
end
