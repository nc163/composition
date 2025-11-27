# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Table, type: :component do
  let(:headers) { %w[Name URL] }
  let(:table_data) {
    [
      [ "Ruby", "https://ruby-lang.org" ],
      [ "Python", "https://python.org" ]
    ]
  }

  it "renders table with headers and rows using context" do
    component = Table.new(headers: headers, table: table_data)
    render_inline(component)

    expect(rendered_content).to include('class="table"')

    # Check headers
    expect(rendered_content).to include("thead")
    expect(rendered_content).to include("Name")
    expect(rendered_content).to include("URL")

    # Check body
    expect(rendered_content).to include("tbody")
    expect(rendered_content).to include("Ruby")
    expect(rendered_content).to include("https://ruby-lang.org")
    expect(rendered_content).to include("Python")
  end

  it "renders without headers if not provided" do
    component = Table.new(table: table_data)
    render_inline(component)

    expect(rendered_content).to include("tbody")
    expect(rendered_content).not_to include("thead")
    expect(rendered_content).to include("Ruby")
  end

  it "renders empty table if no data provided" do
    component = Table.new
    render_inline(component)

    expect(rendered_content).to include("table")
    expect(rendered_content).not_to include("thead")
    expect(rendered_content).not_to include("tbody")
  end
end
