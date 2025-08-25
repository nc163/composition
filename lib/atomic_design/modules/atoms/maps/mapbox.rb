# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      module Maps
        class Mapbox < Base # :nodoc:
          defaults style: 'width: 100%; height: 400px;'

          state :access_token, required: true
          state :lat, required: true
          state :lon, required: true
          state :zoom, values: (1..15), default: 10

          def before_render
            @options[:id] = "mapbox-#{object_id}" unless options[:id]
          end

          def call_as_context
            content_tag :div, '', options do
              concat javascript_tag(render_mapbox_script)
            end
          end

          private

          def render_mapbox_script
            <<-JAVASCRIPT
                document.addEventListener('DOMContentLoaded', function() {
                  mapboxgl.accessToken = "'#{access_token}'";
                  var map = new mapboxgl.Map({
                    container: '#{options[:id]}',
                    style: 'mapbox://styles/mapbox/streets-v11',
                    center: [#{lon}, #{lat}],
                    zoom: #{zoom},
                    dragPan: false
                  });
                });
            JAVASCRIPT
          end
        end
      end
    end
  end
end
