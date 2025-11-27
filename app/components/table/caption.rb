# frozen_string_literal: true

class Table::Caption < ApplicationComponent # :nodoc:
  effect :caption

  def call
    # content_tag :caption, caption, html_options
    content_tag :caption, property(:caption), options
  end
end
