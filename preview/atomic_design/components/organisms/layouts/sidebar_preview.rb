# frozen_string_literal: true

#
module Preview
  module AtomicDesign
    module Components
      module Organisms
        module Layouts
          class SidebarPreview < ViewComponent::Preview
            # @!group default

            def content
              render Sidebar.new(MENU)
            end

            # def block
            #   render Organisms::Sidebar.new do |sidebar|
            #     MENU.each do |element|
            #       concat(sidebar.with_list do |list|
            #         list.with_item do
            #           content_tag(:span, element[:title], class: 'row')
            #         end
            #       end)
            #     end
            #   end
            # end

            private

            MENU = [
              ['menu 1', { url_options: '#' }],
              ['menu 2', { url_options: '#' }],
              ['menu 3', { url_options: '#' }],
              ['menu 4', { url_options: '#' }],
              ['menu 5', { url_options: '#' }]
            ]

            # def menu_options
            #   menu = Organisms::Sidebar::Menu.new
            #   menu.add('Home', href: 'https://example.com')
            #   menu.add('Profile', href: 'https://example.com')
            #   menu.add('Settings', href: 'https://example.com')
            #   menu.add
            #   menu.add('Logout', href: 'https://example.com', target: '_blank')
            # end
          end
        end
      end
    end
  end
end
