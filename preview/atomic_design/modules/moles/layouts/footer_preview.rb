# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Moles
      module Layouts
        class FooterPreview < ::AtomicDesign::Modules::Preview # :nodoc:
          # @!group default

          def content
            render atomic_design.moles.layouts.footer
          end

          # def block
          #   render Moles::Sidebar.new do |sidebar|
          #     MENU.each do |element|
          #       concat(sidebar.with_list do |list|
          #         list.with_item do
          #           content_tag(:span, element[:title], class: 'row')
          #         end
          #       end)
          #     end
          #   end
          # end
        end
      end
    end
  end
end
