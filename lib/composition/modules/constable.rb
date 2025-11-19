# frozen_string_literal: true

module Composition # :nodoc:
  module Modules
    module Constable
      extend ActiveSupport::Concern

      module ClassMethods # :nodoc:
        # 状態管理を移譲する
        # renders_one :head, HeaderComponent
        # renders_one :foot, FooterComponent
        # context :head, [ :title ]
        # context :foot, [ :note ]
        def const(name, options = nil, default: nil, required: false, to: nil)
          def_property Const.new(
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
