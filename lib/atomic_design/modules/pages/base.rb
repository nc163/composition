# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Pages
      # Pages コンポーネント基底クラス
      class Base < Modules::Base
        #
        def atoms
          @atoms ||= module_proxy.atoms
        end

        #
        def moles
          @moles ||= module_proxy.moles
        end

        #
        def orgas
          @orgas ||= module_proxy.orgas
        end

        #
        def temps
          @temps ||= module_proxy.temps
        end

        private

        def module_proxy
          @module_proxy ||= AtomicDesign::Helpers::ModuleHelpers::ModuleProxy.new
        end
      end
    end
  end
end
