# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Orgas
      module Cards
        class TablePreview < ::AtomicDesign::Modules::Preview # :nodoc:
          def default
            render atomic_design.orgas.cards.table []
          end
        end
      end
    end
  end
end
