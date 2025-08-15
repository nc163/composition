# frozen_string_literal: true

#
module Design
  module Component
    module AtomicDesign
      module Molecules
        class Table::Trow::Td < Component
        
          # == Slots
          renders_one :button, Atoms::Button
        
          attr_accessor :url_options
        
          # == Methods
        
          def call
            content_tag :td, attributes do
              if content?
                content
              else
                if url_options.present?
                  concat link_to(context, url_options)
                else
                  context
                end
              end
            end
          end
        
        end
      end
    end
  end
end
