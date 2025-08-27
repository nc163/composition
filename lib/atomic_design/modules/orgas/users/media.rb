# frozen_string_literal: true

module AtomicDesign
  module Modules
    module Orgas
      module Users
        class Media < Base # :nodoc:
          renders_one :head, Atoms::Avatar
        end
      end
    end
  end
end
