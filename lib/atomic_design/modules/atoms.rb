# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms # :nodoc:
      extend ActiveSupport::Autoload

      eager_autoload do
        autoload :Alert
        autoload :Badge
        autoload :Button
        # autoload :Icon
        autoload :List
        # autoload :Metadata
        # autoload :Pagination
      end

      ALERT_LEVELS = {
        info: { class: 'alert-info' },
        success: { class: 'alert-success' },
        warning: { class: 'alert-warning' },
        danger: { class: 'alert-danger' }
      }.freeze

      BADGE_COLORS = {
        primary: { class: 'text-bg-primary' },
        secondary: { class: 'text-bg-secondary' },
        success: { class: 'text-bg-success' },
        danger: { class: 'text-bg-danger' },
        warning: { class: 'text-bg-warning' },
        info: { class: 'text-bg-info' }
      }.freeze

      BUTTON_COLORS = {
        primary: { class: 'bg-primary' },
        secondary: { class: 'bg-secondary' },
        success: { class: 'btn-outline-success' },
        danger: { class: 'bg-danger' },
        warning: { class: 'bg-warning' },
        info: { class: 'bg-info' }
      }.freeze
    end
  end
end
