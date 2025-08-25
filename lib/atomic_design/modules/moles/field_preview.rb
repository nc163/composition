# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Moles
      class FieldPreview < Preview # :nodoc:
        ACCESS_TOKEN = 'pk.eyJ1IjoibmMxNjMiLCJhIjoiY20zczYyY2hlMDVmeTJpbjNnaXFsMDI1ciJ9.qC3AbFcFbaxTGNZK-38H9A'

        # @!group context

        # @param title
        # @param lat
        # @param lon
        # @param zoom
        def context1(title: '何らかのテキスト', lat: 35.681236, lon: 139.767125, zoom: 10)
          context = {
            title: { text: title, class: 'fw-bold' },
            map: { lat: lat, lon: lon, zoom: zoom, access_token: ACCESS_TOKEN }
          }
          render Field.new context
        end

        # @param title
        # @param text
        # @param icon select :icons
        def context2(title: '何らかのテキスト', text: 'いいね！', icon: :nod)
          context = {
            title: { body: title, class: 'fw-bold' },
            icon: { icon: icon },
            body: { body: text }
          }
          render Field.new context
        end

        # @param title
        # @param text
        # @param icon select :icons
        def block(title: '何らかのテキスト', text: 'いいね！', icon: nil)
          render Field.new do |field|
            field.with_label(body: '何らかのテキスト')
            content_tag(:span, text, class: 'row')
          end
        end

        private

        def icons
          { choices: Atoms::Icon::FontAwesome6.icons }
        end
      end
    end
  end
end
