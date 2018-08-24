module GDS
  module Metrics
    def self.configure(&block)
      block.call(Config.instance)
    end

    class Config
      attr_accessor :application_id
      attr_accessor :prometheus_metrics_path
      attr_accessor :mmap_directory
      attr_accessor :use_basic_auth

      def self.instance
        @singleton ||= Config.new
      end

      def populate_from_env
        self.use_basic_auth = fetch_use_basic_auth?
        self.application_id = fetch_application_id
        self.prometheus_metrics_path = fetch_prometheus_metrics_path
        self.mmap_directory = fetch_mmap_directory
      end

      def is_auth_enabled?
        self.use_basic_auth && !self.application_id.nil?
      end

    private

      def fetch_application_id
        vcap_application = JSON.parse(ENV.fetch("VCAP_APPLICATION", "{}"))
        vcap_application["application_id"]
      end

      def fetch_use_basic_auth?
        use_basic_auth = ENV.fetch("METRICS_BASIC_AUTH", "true")
        use_basic_auth == "true"
      end

      def fetch_prometheus_metrics_path
        ENV.fetch("PROMETHEUS_METRICS_PATH", "/metrics")
      end

      def fetch_mmap_directory
        ENV.fetch("MMAP_DIRECTORY", "/tmp")
      end
    end
  end
end
