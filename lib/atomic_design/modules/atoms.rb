# frozen_string_literal: true

module AtomicDesign
  module Modules
    # AtomicDesignに基づいた最小単位のコンポーネントの名前空間
    module Atoms
      extend ActiveSupport::Autoload

      eager_autoload do
        # Class
        autoload :Alert
        autoload :Badge
        autoload :Button
        autoload :List
        # autoload :Metadata
        # autoload :Pagination
        # Module
        autoload :Icons
        autoload :Maps
      end

      AVATAR_SIZES = {
        #
      }.freeze

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
