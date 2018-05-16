module GDS
  module Metrics
    class Middleware
      attr_accessor :wrapped_app

      def initialize(app)
        self.wrapped_app = Rack::Builder.app do
          use GDS::Metrics::Gzip
          use GDS::Metrics::Auth

          if defined?(Rails)
            rails_label_builder = proc do |env|
              method = env['REQUEST_METHOD'].downcase
              path = env['PATH_INFO'].to_s
              host = env['HTTP_HOST'].to_s

              {
                method: method, host: host,
                controller: GDS::Metrics::PathConverter.convert_rails_path_to_route(path, method)
              }
            end

            use Prometheus::Client::Rack::Collector, registry: Proxy.new, &rails_label_builder
          else
            use Prometheus::Client::Rack::Collector, registry: Proxy.new
          end

          use Prometheus::Client::Rack::Exporter

          run app
        end
      end

      def call(env)
        wrapped_app.call(env)
      end
    end
  end
end
