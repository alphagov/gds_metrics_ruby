module GDS
  module Metrics
    class Gzip
      attr_accessor :app

      def initialize(app)
        self.app = app
      end

      def call(env)
        if metrics_path?(env)
          compress(env)
        else
          app.call(env)
        end
      end

    private

      def compress(env)
        Rack::Deflater.new(app).call(env)
      end

      def metrics_path?(env)
        path = env.fetch("PATH_INFO")
        path == config.prometheus_metrics_path
      end

      def config
        Config.instance
      end
    end
  end
end
