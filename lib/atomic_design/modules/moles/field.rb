# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Moles
      class Field < Base # :nodoc:
        # == Slots
        renders_one :mapbox, Atoms::Maps::Mapbox

        # url_for のオプション
        attr_accessor :url_option
        attr_accessor :field

        # == Methods

        def call
          if content?
            content_tag :div, options do
              concat content
            end
          else
            content_tag :div, options do
              concat(content_tag(:label, context.class.human_attribute_name(field), class: 'fw-bold'))
              concat(content_tag(:p) do
                "#{context.send(field)}"
                # if !!map
                #   concat with_mapbox(map)
                # else
                #   concat context
                # end
              end)
            end
          end
        end
      end
    end
  end
end
