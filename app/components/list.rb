# frozen_string_literal: true

class List < ApplicationComponent # :nodoc:
  renders_many :items, "Item"

  basic class: "list-group list-group-flush"
  effect :order?, default: false
end
