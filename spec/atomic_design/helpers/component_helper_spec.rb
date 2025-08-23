# frozen_string_literal: true

require 'spec_helper'

describe AtomicDesign::Helpers::ComponentHelper, type: :helper do # :nodoc:
  let(:view) do
    ActionView::Base.new(ActionView::LookupContext.new([]), {}, nil)
  end

  before do
    view.extend(described_class)
  end

  it 'provides atomic_design proxy on the view' do
    expect(view).to respond_to(:atomic_design)
    expect(view.atomic_design).to respond_to(:atom, :molecule, :organism, :template, :page)

    expect(view.atomic_design.atom.button).to eq '<span class="btn"></span>'
  end

  it '1' do
    expect(view).to respond_to(:atomic_design)
    expect(view.atomic_design.atom.button('テキスト')).to eq '<span class="btn">テキスト</span>'
  end

  it '2' do
    expect(view).to respond_to(:atomic_design)
    expect(view.atomic_design.atom.button('テキスト', id: 'btn-1')).to eq '<span id="btn-1" class="btn">テキスト</span>'
  end

  it '3' do
    expect(view).to respond_to(:atomic_design)
    result = view.link_to 'http://example.com' do
      atomic_design.atom.badge('リンクテキスト')
    end
    expect(result).to eq '<a href="http://example.com"><mark class="badge">リンクテキスト</mark></a>'
  end

  it 'raises an error when referencing a non-existent builder component' do
    expect do
      view.atomic_design.atom.non_existent_component
    end.to raise_error(/is not defined\./)
  end
end
