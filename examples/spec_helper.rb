require File.expand_path(File.dirname(__FILE__) + "/../capistrano")
require File.expand_path(File.dirname(__FILE__) + "/../vendor/mocha/lib/mocha")
require File.expand_path(File.dirname(__FILE__) + "/../vendor/mocha/lib/stubba")

Spec::Runner.configure do |config|
  
  config.mock_with :mocha

end
