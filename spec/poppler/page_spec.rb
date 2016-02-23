require 'spec_helper'

RSpec.describe Poppler::Page do
  let(:file_path) { "spec/fixture/sample.pdf" }
  let(:doc)       { Poppler::Document.new(file_path) }
  let(:page)      { doc.pages.first }

  describe "#index" do
    subject { page.index }
    it { is_expected.to eq 0 }
  end

  describe "#label" do
    subject { page.label }
    it { is_expected.to eq "1" }
  end
end
