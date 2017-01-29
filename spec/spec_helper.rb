require_relative 'support/controller_helpers'
require 'devise'

if ENV.fetch("COVERAGE", false)
    require "simplecov"

    if ENV["CIRCLE_ARTIFACTS"]
      dir = File.join(ENV["CIRCLE_ARTIFACTS"], "coverage")
      SimpleCov.coverage_dir(dir)
    end

    SimpleCov.start "rails"
end

require "webmock/rspec"

# http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
    config.expect_with :rspec do |expectations|
      expectations.syntax = :expect
    end

    config.mock_with :rspec do |mocks|
      mocks.syntax = :expect
      mocks.verify_partial_doubles = true
    end

    config.example_status_persistence_file_path = "tmp/rspec_examples.txt"
    config.order = :random

    config.include ControllerHelpers, type: :controller
    Warden.test_mode!

    config.after do
      Warden.test_reset!
    end
    
end

WebMock.disable_net_connect!(allow_localhost: true)
