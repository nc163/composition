# frozen_string_literal: true

#
module AtomicDesign
  module Components
    module Atom
      module Form
        class SubmitPreview < ::ViewComponent::Preview
          # @!group default

          # @param title
          def default(title: 'Example')
            form_with url: '/', method: :post, local: true, authenticity_token: false do |form|
              render Submit.new('送信', form: form, color: :primary)
            end
          end
        end
      end
    end
  end
end
