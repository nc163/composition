# frozen_string_literal: true

#
module AtomicDesign
  module Component

      module Atom
        module Form
          class TextFieldPreview < ::ViewComponent::Preview

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
