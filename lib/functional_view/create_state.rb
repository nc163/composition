# frozen_string_literal: true

module FunctionalView # :nodoc:
  module CreateState
    extend ActiveSupport::Concern

    #
    class State < Function
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

    module ClassMethods # :nodoc:
      # 状態を定義する
      # state :title,               default: 'Hello World'
      # state :color, COLORS,       default: :primary, to: :html
      # state :time,  (time)=> { "#{((Time.zone.now - time) / 3600).floor}時間前" }
      def state(name, argv = nil, default: nil, required: false, to: nil)
        function = State.new(
          type: :state,
          name: name.to_sym,
          argv: argv,
          to: to,
          default: default,
          required: required
        )
        def_function(function)
      end
    end
  end
end
