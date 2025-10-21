# frozen_string_literal: true

module FunctionalView # :nodoc:
  module Modules
    module Statable
      extend ActiveSupport::Concern

      module ClassMethods # :nodoc:
        # 状態を定義する
        # state :title,               default: 'Hello World'
        # state :color, COLORS,       default: :primary, to: :html
        # state :time,  (time)=> { "#{((Time.zone.now - time) / 3600).floor}時間前" }
        def state(name, options = nil, default: nil, required: false, to: nil)
          def_property State.new(
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
