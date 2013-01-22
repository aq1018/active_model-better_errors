$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'active_model/better_errors'
require 'minitest/unit'

MiniTest::Unit::TestCase.add_setup_hook do
  @__old_errors_class = ActiveModel::Errors
  ActiveModel.stubs(:Errors).returns(ActiveModel::ErrorCollecting::Errors)
end