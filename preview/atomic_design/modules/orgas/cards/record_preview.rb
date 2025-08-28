# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Orgas
      module Cards
        class RecordPreview < ::AtomicDesign::Modules::Preview # :nodoc:
          # @param title
          # @param body
          # @param foot
          def default(title: 'Example', body: 'body', foot: 'footer')
            render atomic_design.orgas.cards.record # TABLE, headers: HEADERS, title: title
          end
        end
      end
    end
  end
end
