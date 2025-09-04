# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Orgas
      module Cards
        class Media < Base # :nodoc:
          # renders_one :card, lambda_slots_component_handler(Moles::Card)
          # renders_one :table, lambda_slots_component_handler(Atoms::Table)
          # renders_one :pagination, lambda_slots_component_handler(Atoms::Pagination)

          state :title
          state :description
          state :headers
        end
      end
    end
  end
end
