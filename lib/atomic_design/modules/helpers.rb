# frozen_string_literal: true

module AtomicDesign
  module Modules
    # コンポーネント用の内部ヘルパーの名前空間
    module Helpers
      extend ActiveSupport::Autoload

      eager_autoload do
        autoload :PropHelper
        autoload :ModuleRefHelper
      end

      extend ActiveSupport::Concern
      include PropHelper
      include ModuleRefHelper
    end
  end
end
