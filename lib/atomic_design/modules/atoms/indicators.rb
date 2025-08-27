# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      module Indicators # :nodoc:
        extend ActiveSupport::Autoload

        eager_autoload do
          # Class
          autoload :Badge
        end

        BADGE_SIZES = {
          sm: { class: 'badge-sm', style: '' },
          lg: { class: 'badge-lg', style: '' }
        }.freeze

        ALERT_LEVELS = {
          info: { class: 'text-bg-info' },
          success: { class: 'text-bg-success' },
          warning: { class: 'text-bg-warning' },
          danger: { class: 'text-bg-danger' }
        }.freeze
      end
    end
  end
end
