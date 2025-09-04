# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Moles
      module Layouts
        class Header < Base # :nodoc:
          renders_one :title, ->(context: "Example") { render atomic_design.moles.layouts.header(context) }
          basic class: "container-xl"
        end
      end
    end
  end
end
