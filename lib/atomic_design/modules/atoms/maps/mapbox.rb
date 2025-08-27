# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      module Maps
        class Mapbox < Base # :nodoc:
          state :access_token, required: true
          state :lat
          state :lon
          state :zoom, values: (1..15)

          def call
            content_tag :div, '', options do
              javascript_tag do
                <<~JAVASCRIPT
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
  end
end
