# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      module Maps
        class GoogleMap < Base # :nodoc:
          defaults style: 'width: 100%; height: 400px;'

          state :access_token, required: true
          state :lat, required: true
          state :lon, required: true
          state :zoom, values: (1..15), default: 10
        end
      end
    end
  end
end
