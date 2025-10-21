# frozen_string_literal: true

class Card < ApplicationComponent # :nodoc:
  renders_one :head, Card::Head
  renders_one :body, Card::Body
  renders_one :foot, Card::Foot

  state :basic, { class: [ "card" ] }, to: :html_options
  # context :head, [ :title ]
end
