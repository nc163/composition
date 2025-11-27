# frozen_string_literal: true

require 'composition'

class DummyList < ::Composition::Component
  renders_many :items, "DummyListItem"

  # We want to populate items from a property 'list_data'
  # context :items, [:list_data]
  # But currently context expects list_data to be passed to with_items (which doesn't exist)

  context :items, [ :list_data ]

  def call
    content_tag :ul do
      items.each do |item|
        concat item
      end
    end
  end
end

class DummyListItem < ::Composition::Component
  state :text

  def call
    content_tag :li, property(:text)
  end
end
