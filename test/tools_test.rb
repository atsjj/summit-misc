require 'test_helper'

require 'summit'

describe Summit::Tools::Configuration do
  describe "#doit" do
    it "returns 2x value" do
      config = Summit::Tools::Configuration.new
      config.doit(2).should == 4
    end
  end
end
