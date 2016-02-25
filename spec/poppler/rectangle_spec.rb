require 'spec_helper'

RSpec.describe Poppler::Rectangle do
  let(:x1) { 100 }
  let(:y1) { 200 }
  let(:x2) { 300 }
  let(:y2) { 400 }
  let(:rectangle) {
    Poppler::Rectangle.new.tap {|r|
      r[:x1] = x1
      r[:y1] = y1
      r[:x2] = x2
      r[:y2] = y2
    }
  }

  describe "properties" do
    it { expect(rectangle.x1).to eq x1 }
    it { expect(rectangle.y1).to eq y1 }
    it { expect(rectangle.x2).to eq x2 }
    it { expect(rectangle.y2).to eq y2 }
  end

  describe "#==" do
    it {
      expect(rectangle).to eq Poppler::Rectangle.new.tap{|r|
        r[:x1] = 100
        r[:y1] = 200
        r[:x2] = 300
        r[:y2] = 400
      }
    }
  end
end
