# frozen_string_literal: true

#
module AtomicDesign
  module Components
    module Organisms
      module Card
        class RecordPreview < ViewComponent::Preview
          def default
            render Record.new(User.first, context)
          end

          private

          def context
            {
              only: %i[id name status my_url],
              except: []
            }
          end
        end
      end
    end
  end
end
