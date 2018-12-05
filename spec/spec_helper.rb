require 'bundler/setup'
require 'rspec'
require 'webmock/rspec'
require 'mercedes'

RSpec.configure do |config|
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  WebMock.disable_net_connect!
end
