require File.join(File.expand_path(File.dirname(__FILE__)), "test_helper")

def configs(*to_include)
  configurations = {
    :min_age => [ 'age > ?', lambda{|v| v.to_i} ],
    :active => [ 'active = ?', lambda{|v| v != '0'} ],
  }
  return configurations.delete_if{ |k,v| to_include.include?(k) == false }
end

describe Summit::Misc::SearchConditions do
  describe "#to_a" do
    it "returns an empty array with no conditions" do
      config = configs(:min_age)
      conditions = SearchConditions.new({}, @params)
      conditions.to_a.should == []
    end

    it "is correct with one condition" do
      config = configs(:min_age)
      conditions = SearchConditions.new config, @params
      conditions.to_a.should == ["age > ?", 18]
    end

    it 'only returns conditions for which it has a param' do
      config = configs(:min_age, :active)
      conditions = SearchConditions.new config, {:min_age => '18'}
      conditions.to_a.should == ["age > ?", 18]
    end

    it 'returns and empty array if there are no params' do
      config = configs(:min_age, :active)
      conditions = SearchConditions.new config, {}
      conditions.to_a.should == []
    end

    it 'returns an empty array if params is nil' do
      config = configs(:min_age, :active)
      conditions = SearchConditions.new config, nil
      conditions.to_a.should == []
    end

    it "is correct with more than one condition" do
      config = configs(:min_age, :active)
      conditions = SearchConditions.new config, @params
      conditions.to_a.should == ["age > ? and active = ?", 18, true]
    end
  end

  before(:all) do
    SearchConditions = Summit::Misc::SearchConditions
  end

  before(:each) do
    @params = {:min_age => '18', :active => '1'}
  end
end
