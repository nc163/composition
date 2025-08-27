# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      module Maps
        class MapboxPreview < ::AtomicDesign::Modules::Preview # :nodoc:
          # @!group default

          # @param lat
          # @param lon
          # @param zoom
          def default(id: 'aaa', lat: 35.681236, lon: 139.767125, zoom: 10)
            render atomic_design.atoms.maps.mapbox(id: id, lat: lat, lon: lon, zoom: zoom,
                                                   access_token: ENV['MAPBOX_ACCESS_TOKEN'],
                                                   style: 'width: 100%; height: 400px;')
          end
        end
      end
    end
  end
end
