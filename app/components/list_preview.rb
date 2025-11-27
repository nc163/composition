# frozen_string_literal: true

class ListPreview < ApplicationComponentPreview # :nodoc:
  def un_ordered_list
    render List.new do |list|
      LIST.each { |item| list.with_item { item } }
    end
  end

  def ordered_list
    render List.new(order?: true) do |list|
      LIST.each { |item| list.with_item { item } }
    end
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
