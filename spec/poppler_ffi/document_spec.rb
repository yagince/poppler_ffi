require 'spec_helper'

RSpec.describe PopplerFFI::Document do
  let(:file_path) { "spec/fixture/sample.pdf" }
  let(:doc) { PopplerFFI::Document.new(file_path) }

  describe "new" do
    subject { PopplerFFI::Document.new(file_path) }
    it { expect { subject }.not_to raise_error }
  end

  describe "properties" do
    # TODO: `format` property is pending
    %i(author title).each{|prop|
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

  describe "#subject" do
    subject { doc.subject }
    it { is_expected.to be_nil }
  end

  describe "#keywords" do
    subject { doc.keywords }
    it { is_expected.to be_empty }
  end

  describe "#created_date" do
    subject { doc.created_date }
    it { is_expected.to eq Time.local(2016,2,22,4,25,37) }
  end

  describe "#updated_date" do
    subject { doc.created_date }
    it { is_expected.to eq Time.local(2016,2,22,4,25,37) }
  end

  describe "#page_layout" do
    subject { doc.page_layout }
    it { is_expected.to eq :unset }
  end

  describe "#page_count" do
    subject { doc.page_count }
    it { is_expected.to eq 1 }
  end

  describe "#pages" do
    subject { doc.pages }
    it { is_expected.to all(a_kind_of(PopplerFFI::Page)) }
  end

  describe "#page_mode" do
    subject { doc.page_mode }
    it { is_expected.to eq :unset }
  end

  describe "#permissions" do
    subject { doc.permissions }
    it { is_expected.to be_a PopplerFFI::Permissions }
  end

  context 'to many open files' do
    let(:num) { 1000 }
    it {
      num.times { |i|
        PopplerFFI::Document.new(file_path)
      }
    }
  end
end
