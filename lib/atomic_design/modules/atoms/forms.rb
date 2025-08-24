# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      module Forms # :nodoc:
        extend ActiveSupport::Autoload

        eager_autoload do
          autoload :TextField
          autoload :TextArea
          autoload :DatetimeField
          autoload :DateField
          autoload :TimeField
          autoload :CheckBoxField

          autoload :Confirms
        end
      end
    end
  end
end
