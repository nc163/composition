# frozen_string_literal: true

module AtomicDesign
  module Helpers # :nodoc:
    module Modules # :nodoc:
      extend ActiveSupport::Autoload

      eager_autoload do
        autoload :CheckBox
        autoload :DateField
        autoload :DatetimeField
        autoload :EmailField
        autoload :Select
        autoload :Submit
        autoload :TextArea
        autoload :TextField
        autoload :TimeField
        autoload :UrlField
      end
    end
  end
end
