require "rack"

require "prometheus/client"
require "prometheus/client/rack/collector"
require "prometheus/client/rack/exporter"

require "gds_metrics/version"
require "gds_metrics/mmap"
require "gds_metrics/middleware"
require "gds_metrics/proxy"
require "gds_metrics/config"
require "gds_metrics/auth"
require "gds_metrics/gzip"
require "gds_metrics/uptime"
require "gds_metrics/railtie" if defined?(Rails)
require "gds_metrics/path_converter"

GDS::Metrics::Config.instance.populate_from_env
GDS::Metrics::Mmap.setup
