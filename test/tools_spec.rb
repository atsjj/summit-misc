require File.join(File.expand_path(File.dirname(__FILE__)), "test_helper")

require 'summit'

def config_path
  return File.join(File.expand_path(File.dirname(__FILE__)), 'configuration.yaml')
end

describe Summit::Tools::Configuration do
  describe "#doit" do
    it "returns 2x value" do
      @config.doit(2).should == 4
    end
  end

  describe "#new" do
    it "recursively symbolizes keys" do
      @config.hash1[:hash2][:key12a].should == 'value12a'
      @config.hash1[:array2][0][:key123a].should == 'value123a'
    end
  end

  describe "#method" do
    it "looks up a value on missing method" do
      @config.array1[0].should == 'value1a'
    end
  end

  before(:all) do
    @config = Summit::Tools::Configuration.new config_path
  end

end
