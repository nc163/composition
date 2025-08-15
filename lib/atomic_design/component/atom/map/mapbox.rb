# frozen_string_literal: true

#
module AtomicDesign
  module Component

      module Atom
        class Map::Mapbox < Component
        
          default_layout style: 'width: 100%; height: 400px;'
        
          # == Attributes
          attr_accessor :lon, # 139.767125
                        :lat, # 35.681236
                        :zoom # 1 - 15 ?
        
          def before_render
            @options[:id] = "mapbox-#{object_id}" unless attributes[:id]
          end
        
          def call_as_context
            content_tag :div, '', attributes do
              concat javascript_tag(render_mapbox_script)
            end
          end
        
          private
        
          def render_mapbox_script
            <<-JAVASCRIPT
              document.addEventListener('DOMContentLoaded', function() {
                mapboxgl.accessToken = '#{ACCESS_TOKEN}';
                var map = new mapboxgl.Map({
                  container: '#{attributes[:id]}',
                  style: 'mapbox://styles/mapbox/streets-v11',
                  center: [#{lon}, #{lat}],
                  zoom: #{zoom},
                  dragPan: false
                });
              });
            JAVASCRIPT
          end
        
          ACCESS_TOKEN = 'pk.eyJ1IjoibmMxNjMiLCJhIjoiY20zczYyY2hlMDVmeTJpbjNnaXFsMDI1ciJ9.qC3AbFcFbaxTGNZK-38H9A'
        
        end

      end
  end
end
