require 'simplecov'
SimpleCov.start { add_filter "/spec/" }

Dir['spec/fakes/**/*.rb'].each { |file| load file }
require_relative '../lib/farmbot-pi'
require_relative '../lib/controllers/exec_sequence_controller'
require_relative '../lib/command_objects/commands'
require_relative '../lib/models/status_storage.rb'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end

# This is used for testing things that require an event loop. Once run, you can
# observe / make assertions on side effects.
def within_event_loop(ticks = 20)
  EM.run do
    bot.status[:BUSY] = 0
    EM.tick_loop { (ticks < 1) ? EM.stop : ticks -= 1 }
    yield
  end
end
