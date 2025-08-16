require 'spec_helper'

RSpec.describe AtomicDesign::Helpers::FormHelper, type: :helper do
  let(:view) do
    ActionView::Base.new(ActionView::LookupContext.new([]), {}, ActionController::Base.new)
  end

  before do
    view.extend(described_class)
  end

  it 'renders form_with with a simple block' do
    html = view.form_with(url: '/test') do |f|
      f.text_field :name
    end

    expect(html).to include('<input')
  end
end
