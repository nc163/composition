# frozen_string_literal: true

module FunctionalView # :nodoc:
  module Modules
    module Basicable
      extend ActiveSupport::Concern

      module ClassMethods # :nodoc:
        # 状態管理を移譲する
        # renders_one :head, HeaderComponent
        # renders_one :foot, FooterComponent
        # context :head, [ :title ]
        # context :foot, [ :note ]
        def basic(name, options = nil, default: nil, required: false, to: nil)
          def_property Context.new(
            name: name.to_sym,
            params: options,
            default: default,
            required: required,
            to: to,
          )
        end
      end
    end
  end
end
