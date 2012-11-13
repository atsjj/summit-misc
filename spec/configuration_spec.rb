require 'spec_helper'

def config_path
  return File.join(File.expand_path(File.dirname(__FILE__)), 'configuration.yaml')
end

describe Summit::Misc::Configuration do
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

  # delegators for Hash methods
  describe "#[]" do
    it "acts like Hash" do
      @config[:hash1].class.should == Hash
    end
  end

  describe "#[]=" do
    it "acts like Hash" do
      @config[:new] = 1
      @config[:new].should == 1
    end
  end

  describe "#length" do
    it "acts like Hash" do
      orig_length = @config.length
      @config[:new] = 1
      @config.length.should == orig_length + 1
    end
  end

  describe "#each" do
    it "acts like Hash" do
      enumerator = @config.each
      enumerator.class.should eq(Enumerator)
      [Hash, Array].include?(enumerator.next.class).should == true
    end
  end

  describe "#collect" do
    it "acts like Hash" do
      enumerator = @config.collect
      enumerator.class.should eq(Enumerator)
      [Hash, Array].include?(enumerator.next.class).should == true
    end
  end

  describe "#keys" do
    it "acts like Hash" do
      @config.keys.sort{|x,y| x.to_s <=> y.to_s}.should == [:array1, :hash1]
    end
  end

  describe "#values" do
    it "acts like Hash" do
      @config.values.length.should == 2
    end
  end

  before(:each) do
    @config = Summit::Misc::Configuration.new config_path
  end

end
