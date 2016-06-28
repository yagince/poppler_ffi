require 'spec_helper'

RSpec.describe PopplerFFI::Rectangle do
  let(:x1) { 100 }
  let(:y1) { 200 }
  let(:x2) { 300 }
  let(:y2) { 400 }
  let(:rectangle) {
    PopplerFFI::Rectangle.new(x1, y1, x2, y2)
  }

  describe "properties" do
    it { expect(rectangle.x1).to eq x1 }
    it { expect(rectangle.y1).to eq y1 }
    it { expect(rectangle.x2).to eq x2 }
    it { expect(rectangle.y2).to eq y2 }
  end

  describe "#==" do
    it {
      expect(rectangle).to eq PopplerFFI::Rectangle.new(x1, y1, x2, y2)
    }
  end

  describe "#to_ffi" do
    subject { rectangle.to_ffi }
    it { is_expected.to be_a PopplerFFI::RectangleFFI }
  end
end
