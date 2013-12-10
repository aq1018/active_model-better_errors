$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'

require 'active_model'
require 'active_model/better_errors'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
end

class String
  def ==(other)
    return super other.to_s if other.is_a? ActiveModel::ErrorCollecting::ErrorMessage
    super
  end
end
