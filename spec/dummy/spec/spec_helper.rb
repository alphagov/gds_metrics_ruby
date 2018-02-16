ENV["RAILS_ENV"] ||= "test"

require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
require "pry"

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.formatter = :doc
  config.color = true
end
