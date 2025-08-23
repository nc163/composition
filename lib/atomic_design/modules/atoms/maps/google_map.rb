# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      module Maps
        class GoogleMap < ::AtomicDesign::Modules::Base # :nodoc:
          attributes style: 'width: 100%; height: 400px;'

          prop :access_token, required: true
          prop :lat, required: true
          prop :lon, required: true
          prop :zoom, values: (1..15), default: 10
        end
      end
    end
  end
end
