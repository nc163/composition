# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      module Forms # :nodoc:
        extend ActiveSupport::Autoload

        eager_autoload do
          # Class
          autoload :TextField
          autoload :TextArea
          autoload :DatetimeField
          autoload :DateField
          autoload :TimeField
          autoload :CheckBox
          # Module
          autoload :Confirms
        end
      end
    end
  end
end
