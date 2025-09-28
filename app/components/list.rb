# frozen_string_literal: true

class List < ApplicationComponent # :nodoc:
  renders_many :items, "Item"

  basic class: "list-group list-group-flush"
  state :order?, default: false
end
