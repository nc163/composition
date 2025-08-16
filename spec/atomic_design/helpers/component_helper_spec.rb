require 'spec_helper'

RSpec.describe AtomicDesign::Helpers::ComponentHelper, type: :helper do
  let(:view) do
    ActionView::Base.new(ActionView::LookupContext.new([]), {}, nil)
  end

  before do
    view.extend(described_class)
  end

  it 'provides atomic_design builder on the view' do
    expect(view).to respond_to(:atomic_design)
    builder = view.atomic_design
    expect(builder).to respond_to(:atom, :molecule, :organism, :template, :page)

    expect(view.atomic_design.atom.button).to eq '<span class="btn"></span>'
  end
end
