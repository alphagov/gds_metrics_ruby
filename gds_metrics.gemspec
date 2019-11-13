$LOAD_PATH.push("lib")

require "gds_metrics/version"

Gem::Specification.new do |s|
  s.name        = "gds_metrics"
  s.version     = GDS::Metrics::VERSION
  s.licenses    = ["MIT"]
  s.summary     = "GDS Metrics"
  s.description = "Instrument your web app to export Prometheus metrics."
  s.author      = "Government Digital Service"
  s.email       = "reliability-engineering-tools-team@digital.cabinet-office.gov.uk"
  s.homepage    = "https://github.com/alphagov/gds_metrics_ruby"
  s.files       = ["README.md"] + Dir["lib/**/*.*"]

  s.add_dependency "prometheus-client-mmap", "0.9.1"

  s.add_development_dependency "pry", "0.11.3"
  s.add_development_dependency "rails", "5.1.4"
  s.add_development_dependency "rake", "12.3.0"
  s.add_development_dependency "rspec", "3.7.0"
  s.add_development_dependency "rspec-rails", "3.7.2"
  s.add_development_dependency "rubocop-govuk", "1.0.0"
end
