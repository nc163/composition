# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Orgas
      # Orgas コンポーネント基底クラス
      class Base < Modules::Base
        #
        def atoms
          @atoms ||= AtomicDesign::Helpers::ModuleHelper::ModuleBuilder.new('atomic_design/modules/atoms')
        end

        #
        def moles
          @moles ||= AtomicDesign::Helpers::ModuleHelper::ModuleBuilder.new('atomic_design/modules/moles')
        end
      end
    end
  end
end
