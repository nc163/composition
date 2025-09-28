# frozen_string_literal: true

#
require "active_support/concern"

module FunctionalView # :nodoc:
  module Property
    module Contextable
      extend ActiveSupport::Concern
      module ClassMethods # :nodoc:
        # 状態管理を移譲する
        # renders_one :head, HeaderComponent
        # renders_one :foot, FooterComponent
        # context :head, [ :title ]
        # context :foot, [ :note ]
        def context(name, argv = nil, default: nil, required: false, to: nil)
          function_options = {
            type: :context,
            name: name.to_sym,
            argv: argv,
            to: to,
            default: default,
            required: required
          }
          def_function(**function_options)
        end
      end

      class Context < Functions::Action
      end
    end
  end
end
