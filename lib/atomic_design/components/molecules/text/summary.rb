# frozen_string_literal: true

#
module AtomicDesign
  module Components
    module Molecules # :nodoc:
      class Text::Summary < ::AtomicDesign::Components::Base
        # == Properties
        # property :type, text: { class: 'text-primary' }
        # property :type, link: { class: 'text-primary' }
        # property :type, badge: { class: 'text-primary' }
        # property :type, button: { class: 'text-primary' }

        # == Constants
        # Nop

        # == Slots
        renders_one :badge, AtomicDesign::Components::Atoms::Metadata::Badge

        # == Attributes
        attr_accessor :label, :href, :target, :rel
        attr_accessor :context

        # == Methods

        def call
          content_tag :div, attributes do
            if href.present?
              call_if_link
            else
              call_if_text
            end
          end
        end

        private

        def call_if_link
          link_to href, target: target do
            concat content_tag :label, context, class: 'fw-bold'
            concat with_badge(label, property: { color: :primary }) if label.present?
          end
        end

        def call_if_text
          concat content_tag :label, context, class: 'fw-bold'
          concat with_badge(label, property: { color: :primary }) if label.present?
        end
      end
    end
  end
end
