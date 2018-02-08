require "rspec"
require "pry"
require "gds_metrics"

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.formatter = :doc
  config.color = true
end
