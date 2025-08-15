# frozen_string_literal: true

# ==
module Design
  module Component
    module AtomicDesign
      module Organisms
        class Footer < Component

          # == Layout
          default_layout id: 'global-footer', class: '', style: 'position: sticky; top: 100vh; top: 100dvh;'

          # == Slots
          # Nop

          # # == Attributes
          # Nop

          # == Methods

          def call
            content_tag :footer, attributes do
              content_tag :nav, class: %q(
                flex h-10
                md:h-12
                lg:h-16
                xl:h-20
                2xl:h-24
              ) do
                concat content_tag(:p, 'developmentモード')
                concat content_tag(:p, '©️ 2024 nadokoro.jp')
              end
            end
          end

        end
      end
    end
  end
end
