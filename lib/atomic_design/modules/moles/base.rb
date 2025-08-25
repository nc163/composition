# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Moles
      # Moles コンポーネント基底クラス
      class Base < Modules::Base
        #
        def atoms
          @atoms ||= AtomicDesign::Helpers::ModuleHelper::ModuleBuilder.new('atomic_design/modules/atoms')
        end
      end
    end
  end
end
