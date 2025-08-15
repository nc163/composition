# frozen_string_literal: true

#
module Design
  module Component
    module AtomicDesign
      module Atoms
        module Form
          class TextFieldPreview < ViewComponent::Preview

            # @!group default

            # @param title
            def default(title: "Example")
              render TextField.new("title", form: nil, value: title)
            end

          end

        end
      end
    end
  end
end
