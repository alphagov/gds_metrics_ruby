require "rack"

require "prometheus/client"
require "prometheus/client/rack/collector"
require "prometheus/client/rack/exporter"

Prometheus::Client.configuration.multiprocess_files_dir = "/tmp" # TODO

require "gds_metrics/version"
require "gds_metrics/middleware"
require "gds_metrics/config"
require "gds_metrics/auth"
require "gds_metrics/gzip"

require "gds_metrics/railtie" if defined?(Rails)

GDS::Metrics::Config.instance.populate_from_env
