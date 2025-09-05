# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Orgas
      module Cards
        class Table < Base # :nodoc:
          renders_one :card, Moles::Card# lambda_slots_component_handler(Moles::Card)
          renders_one :table, Atoms::Table# lambda_slots_component_handler(Atoms::Table)
          renders_one :pagination, Atoms::Pagination# lambda_slots_component_handler(Atoms::Pagination)

          state :title
          state :headers
          # context :only
        end
      end
    end
  end
end
