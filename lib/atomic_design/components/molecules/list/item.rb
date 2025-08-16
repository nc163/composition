# frozen_string_literal: true

#
module AtomicDesign
  module Components
    module Molecules # :nodoc:
      class List::Item < ::AtomicDesign::Components::Base
        # == Layout
        default_layout class: 'list-group-item'

        # url_options, is passed to url_for
        attr_accessor :url_options

        # == Methods
        def call
          content_tag :li, attributes do
            if_wrap_with_link do
              if content?
                content
              else
                context
              end
            end
          end
        end

        private

        def if_wrap_with_link
          concat(url_options.present? ? link_to(yield, url_for(url_options)) : yield)
        end
      end
    end
  end
end
