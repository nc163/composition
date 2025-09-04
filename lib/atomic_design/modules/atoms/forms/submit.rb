# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Atoms
      module Forms
        class Submit < Base # :nodoc:
          # == Layout
          basic class: "btn"

          # attrs :color, primary: { class: 'btn-primary' },
          #               secondary: { class: 'btn-secondary' },
          #               success: { class: 'btn-success' },
          #               danger: { class: 'btn-danger' },
          #               warning: { class: 'btn-warning' },
          #               info: { class: 'btn-info' }

          # def call
          #   concat form.submit(context, use_default: true, options)
          # end
        end
      end
    end
  end
end
