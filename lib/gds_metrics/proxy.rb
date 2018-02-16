module GDS
  module Metrics
    class Proxy
      def initialize(registry = Prometheus::Client.registry)
        @registry = registry
      end

      def counter(metric_name, *args)
        @registry.counter(rename(metric_name), *args)
      end

      def histogram(metric_name, *args)
        @registry.histogram(rename(metric_name), *args)
      end

      def summary(*)
        NullSummary.new
      end

    private

      def rename(metric_name)
        {
          http_requests_total: :http_server_requests_total,
          http_exceptions_total: :http_server_exeptions_total,
          http_req_duration_seconds: :http_server_request_duration_seconds,
        }.fetch(metric_name, metric_name)
      end

      class NullSummary
        def observe(*); end
      end
    end
  end
end
