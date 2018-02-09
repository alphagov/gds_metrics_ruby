module GDS
  module Metrics
    def self.configure(&block)
      block.call(Config.instance)
    end

    class Config
      attr_accessor :application_id
      attr_accessor :prometheus_metrics_path
      attr_accessor :auth_enabled

      def self.instance
        @singleton ||= Config.new
      end

      def populate_from_env
        self.application_id = fetch_application_id
        self.prometheus_metrics_path = fetch_prometheus_metrics_path
        self.auth_enabled = !application_id.nil?
      end

      private

      def fetch_application_id
        vcap_application = JSON.parse(ENV.fetch("VCAP_APPLICATION", "{}"))
        vcap_application["application_id"]
      end

      def fetch_prometheus_metrics_path
        ENV.fetch("PROMETHEUS_METRICS_PATH", "/metrics")
      end
    end
  end
end
