require 'spec_helper'

describe Hipbot::Plugins::MemeGenerator::Generator do
  let(:meme) { double }

  describe "splitting text" do
    it "should split text according to quotation marks" do
      generator = described_class.new(meme, '"I don\'t always do a deploy" "but when I do, I do it on friday"')
      expect(generator.upper_text).to eq "I don\'t always do a deploy"
      expect(generator.lower_text).to eq "but when I do, I do it on friday"
    end

    it "should split text evenly" do
      generator = described_class.new(meme, 'I don\'t always do a deploy but when I do, I do it on friday')
      expect(generator.upper_text).to eq "I don't always do a deploy but"
      expect(generator.lower_text).to eq "when I do, I do it on friday"
    end

    it "should not split monolithic text" do
      generator = described_class.new(meme, 'ermagherdtestdrivendevelopment')
      expect(generator.upper_text).to eq "ermagherdtestdrivendevelopment"
      expect(generator.lower_text).to eq ""
    end
  end
end
