# frozen_string_literal: true

module AtomicDesign
  module ModulePreviews
    module Atoms
      class ListPreview < Base # :nodoc:
        def un_ordered_list
          render atomic_design.atoms.list LIST
        end

        def ordered_list
          render atomic_design.atoms.list LIST, order?: true
        end

        LIST = [
          'Ruby',
          'Python',
          'JavaScript',
          'Go',
          'Java',
          'PHP',
          'C++',
          'C#',
          'TypeScript',
          'Kotlin'
        ]
      end
    end
  end
end
