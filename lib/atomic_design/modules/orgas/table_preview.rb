# frozen_string_literal: true

#
module AtomicDesign
  module Modules
    module Orgas
      class CardTablePreview < Preview # :nodoc:
        def default
          render Table.new WebPage.page(1).per(10)
        end
      end
    end
  end
end
