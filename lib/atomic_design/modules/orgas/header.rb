# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Orgas
      class Header < Base # :nodoc:
        # == Layout
        attrs id: 'global-header', class: '', style: 'position: sticky; top: 100vh; top: 100dvh;'

        # == Slots
        # Nop

        # # == Attributes
        # Nop

        # == Methods

        def call
          content_tag :header, attributes do
            content_tag :nav, class: '
                flex h-10
                md:h-12
                lg:h-16
                xl:h-20
                2xl:h-24
              ' do
            end
          end
        end
      end
    end
  end
end
