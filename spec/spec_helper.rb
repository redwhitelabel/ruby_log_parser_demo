path = File.expand_path("#{File.dirname(__FILE__)}/../")
$LOAD_PATH.unshift(path) unless $LOAD_PATH.include?(File.expand_path(path))

require 'simplecov'

SimpleCov.start

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
