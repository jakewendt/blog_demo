ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
include AuthenticatedTestHelper

class ActiveSupport::TestCase
	self.use_transactional_fixtures = true
	self.use_instantiated_fixtures  = false
	fixtures :all
end
