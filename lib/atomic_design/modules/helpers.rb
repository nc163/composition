# frozen_string_literal: true

require "forwardable"

module AtomicDesign
  module Modules
    # コンポーネント用の内部ヘルパーの名前空間
    module Helpers
      extend ActiveSupport::Autoload

      eager_autoload do
        # Class
        autoload :Property
        # Module
        autoload :PropertyHelpers
        autoload :ModuleRefHelper
      end

      extend ActiveSupport::Concern
      include PropertyHelpers
      include ModuleRefHelper
    end
  end
end
