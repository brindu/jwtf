require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "jwtf"

require 'support/token_decode'

require "minitest/autorun"
require 'minitest/reporters'
require 'minitest/ci'

if ENV['CIRCLECI']
  Minitest::Ci.report_dir = '/tmp/test-results'
end

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]
