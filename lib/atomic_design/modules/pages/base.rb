# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Pages
      # Pages コンポーネント基底クラス
      class Base < Modules::Base
        #
        def atoms
          @atoms ||= AtomicDesign::Helpers::ModuleHelper::ModuleBuilder.new('atomic_design/modules/atoms')
        end

        #
        def moles
          @moles ||= AtomicDesign::Helpers::ModuleHelper::ModuleBuilder.new('atomic_design/modules/moles')
        end

        #
        def orgas
          @orgas ||= AtomicDesign::Helpers::ModuleHelper::ModuleBuilder.new('atomic_design/modules/orgas')
        end

        #
        def temps
          @temps ||= AtomicDesign::Helpers::ModuleHelper::ModuleBuilder.new('atomic_design/modules/temps')
        end
      end
    end
  end
end
