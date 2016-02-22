require 'spec_helper'

RSpec.describe Poppler::Document do
  let(:file_path) { "spec/fixture/sample.pdf" }
  let(:doc) { Poppler::Document.new(file_path) }

  describe "new" do
    subject { Poppler::Document.new(file_path) }
    it { expect { subject }.not_to raise_error }
  end

  describe "properties" do
    %i(author format title).each{|prop|
      it "#{prop.to_s} is not empty" do
        expect(doc[prop]).not_to be_empty
      end
    }
  end

  describe "#pdf_version" do
    subject { doc.pdf_version }
    it { is_expected.to eq "PDF-1.3" }
  end

  describe "#title" do
    subject { doc.title }
    it { is_expected.to eq "Workbook1" }
  end

  describe "#author" do
    subject { doc.author }
    it { is_expected.to be_nil }
  end
end
