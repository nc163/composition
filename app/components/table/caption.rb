# frozen_string_literal: true

class Table::Caption < ApplicationComponent # :nodoc:
  state :caption

  def call
    # content_tag :caption, caption, html_options
    content_tag :caption, caption, options
  end
end
