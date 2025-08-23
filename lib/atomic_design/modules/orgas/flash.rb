# frozen_string_literal: true

# ==
module AtomicDesign
  module Modules
    module Orgas # :nodoc:
      class Flash < ::AtomicDesign::Base
        # # == Attributes
        attr_accessor :flash

        private

        def flash?
          # alert? || notice?
        end

        def alert?
          # flash.key?(:alert)
        end

        def notice?
          # flash.key?(:notice)
        end

        def message
          @flash[:alert] || @flash[:notice]
        end
      end
    end
  end
end
