# frozen_string_literal: true

#
module Design
  module Component
    module AtomicDesign
      module Atoms
        module Map
          class MapboxPreview < ViewComponent::Preview
          
            ACCESS_TOKEN = 'pk.eyJ1IjoibmMxNjMiLCJhIjoiY20zczYyY2hlMDVmeTJpbjNnaXFsMDI1ciJ9.qC3AbFcFbaxTGNZK-38H9A'
          
            # @!group default
          
            # @param lat
            # @param lon
            # @param zoom
            def default(lat: 35.681236, lon: 139.767125, zoom: 10)
              render Mapbox.new lat: lat, lon: lon, zoom: zoom, access_token: ACCESS_TOKEN
            end
          
          end

        end
      end
    end
  end
end