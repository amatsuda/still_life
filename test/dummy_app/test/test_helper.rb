ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

case ENV['TEST_FRAMEWORK']
when 'test-unit'
  require 'test/unit/rails/test_help'
else
  require 'rails/test_help'
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
