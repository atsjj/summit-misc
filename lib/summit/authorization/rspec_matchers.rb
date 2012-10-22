# rspec matchers
RSpec::Matchers.define :be_not_authorized do
  match do |response|
    response.code == "401" && response.body.should =~ /Not Authorized/i
  end
end

RSpec::Matchers.define :be_authorized do
  match do |response|
    response.code != "401"
  end
end
