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

  describe "#page_size" do
    subject { page.page_size }
    it { is_expected.to eq({ width: 595.0, height: 842.0 }) }
  end

  describe "#crop_box" do
    subject { page.crop_box }

    it { is_expected.to be_a Poppler::Rectangle }

    it 'properties' do
      expect(subject.x1).to eq 0.0
      expect(subject.y1).to eq 0.0
      expect(subject.x2).to eq 595.0
      expect(subject.y2).to eq 842.0
    end
  end

  describe "#duration" do
    subject { page.duration }
    it { is_expected.to eq -1.0 }
  end

  describe "#text" do
    context "without rectangle" do
      subject { page.text }
      it { is_expected.to eq "Test\n1\nA\n2\nB\n3\nC" }
    end

    context "with rectangle" do
      let(:area) {
        Poppler::Rectangle.new.tap{|r|
          r[:x1] = 100
          r[:y1] = 300
          r[:x2] = 500
          r[:y2] = 600
        }
      }

      subject { page.text(area) }

      it { is_expected.to eq "B\n3\nC" }
    end
  end

end
