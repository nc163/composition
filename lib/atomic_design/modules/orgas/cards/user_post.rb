# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Orgas
      module Cards
        class UserPost < Base # :nodoc:
          renders_one :card, lambda_slots_component_handler(Moles::Card)
          renders_one :user, lambda_slots_component_handler(Atoms::Avatar)

          state :title
          state :body
        end
      end
    end
  end
end
