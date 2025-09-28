# frozen_string_literal: true

class ListPreview < ApplicationComponentPreview # :nodoc:
  def un_ordered_list
    render atomic_design.atoms.list LIST
  end

  def ordered_list
    render atomic_design.atoms.list LIST, order?: true
  end

  LIST = [
    "Ruby",
    "Python",
    "JavaScript",
    "Go",
    "Java",
    "PHP",
    "C++",
    "C#",
    "TypeScript",
    "Kotlin"
  ]
end
