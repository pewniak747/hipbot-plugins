require 'spec_helper'

describe Hipbot::Plugins::MemeGenerator::Generator do
  let(:meme) { stub.as_null_object }

  describe "splitting text" do
    it "should split text according to quotation marks" do
      generator = described_class.new(meme, '"I don\'t always do a deploy" "but when I do, I do it on friday"')
      generator.upper_text.should == "I don\'t always do a deploy"
      generator.lower_text.should == "but when I do, I do it on friday"
    end

    it "should split text evenly" do
      generator = described_class.new(meme, 'I don\'t always do a deploy but when I do, I do it on friday')
      generator.upper_text.should == "I don't always do a deploy but"
      generator.lower_text.should == "when I do, I do it on friday"
    end

    it "should not split monolithic text" do
      generator = described_class.new(meme, 'ermagherdtestdrivendevelopment')
      generator.upper_text.should == "ermagherdtestdrivendevelopment"
      generator.lower_text.should == ""
    end
  end
end
