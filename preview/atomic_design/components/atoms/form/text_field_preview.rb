# frozen_string_literal: true

#
module Preview
  module AtomicDesign
    module Components
      module Atom
        module Form
          class TextFieldPreview < ::ViewComponent::Preview
            # @!group default

            # @param title
            def default(title: 'Example')
              render TextField.new('title', form: nil, value: title)
            end
          end
        end
      end
    end
  end
end
