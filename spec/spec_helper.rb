require 'rspec'
require 'rspec/autorun'
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'summit'

# require 'factory_girl'
# Dir[File.join(__FILE__, '..', "factories/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
end
