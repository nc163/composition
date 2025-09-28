# frozen_string_literal: true

require "active_support/concern"

module FunctionalView # :nodoc:
  module Property
    module Statable
      extend ActiveSupport::Concern
      module ClassMethods # :nodoc:
        # 状態を定義する
        # state :title,               default: 'Hello World'
        # state :color, COLORS,       default: :primary, to: :html
        # state :time,  (time)=> { "#{((Time.zone.now - time) / 3600).floor}時間前" }
        def state(name, argv = nil, default: nil, required: false, to: nil)
          function_options = {
            type: :state,
            name: name.to_sym,
            argv: argv,
            to: to,
            default: default,
            required: required
          }
          def_function(**function_options)
        end
      end
    end
  end
end
