require 'spec_helper'

RSpec.describe PopplerFFI::Page do
  let(:file_path) { "spec/fixture/sample.pdf" }
  let(:doc)       { PopplerFFI::Document.new(file_path) }
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

  describe "thumbnail_size" do
    subject { page.thumbnail_size }
    it { is_expected.to eq({ width: 0.0, height: 0.0 }) }
  end

  describe "#crop_box" do
    subject { page.crop_box }

    it { is_expected.to be_a PopplerFFI::Rectangle }

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
        PopplerFFI::Rectangle.new(100, 300, 500, 600)
      }

      subject { page.text(area) }

      it { is_expected.to eq "B\n3\nC" }
    end
  end

  def rectangle(x1, y1, x2, y2)
    PopplerFFI::Rectangle.new(x1, y1, x2, y2)
  end

  describe "text_layout" do
    subject { page.text_layout }
    it { expect(subject.size).to eq 16 }
    it { is_expected.to all(a_kind_of PopplerFFI::Rectangle) }
    it {
      is_expected.to eq [rectangle(53,      55.576,  58.8476, 70.228),
                         rectangle(58.8476, 55.576,  64.8152, 70.228),
                         rectangle(64.8152, 55.576,  69.5108, 70.228),
                         rectangle(69.5108, 55.576,  73.5308, 70.228),
                         rectangle(73.5308, 70.228,  73.5308, 70.228),
                         rectangle(107,     87.576,  113.084, 102.228),
                         rectangle(113.084, 102.228, 113.084, 102.228),
                         rectangle(53,      103.576, 59.948,  118.228),
                         rectangle(59.948,  118.228, 59.948,  118.228),
                         rectangle(172,     87.576,  178.084, 102.228),
                         rectangle(178.084, 102.228, 178.084, 102.228),
                         rectangle(118,     103.576, 124.528, 118.228),
                         rectangle(124.528, 118.228, 124.528, 118.228),
                         rectangle(237,     87.576,  243.084, 102.228),
                         rectangle(243.084, 102.228, 243.084, 102.228),
                         rectangle(183,     103.576, 189.39600000000002, 118.228)]
    }
  end

  describe 'render' do
    let(:path) { 'test.pdf' }
    after { File.delete(path) if File.exist? path }

    it {
      Cairo::PDFSurface.create(path, 500, 400) {|s|
        c = Cairo::Context.create(s)
        c.rectangle(10, 10, 100, 100)
        c.stroke
        c.show_page
      }
      expect(File.exist?(path)).to be_truthy
    }
  end
end
