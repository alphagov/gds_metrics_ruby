module GDS
  module Metrics
    class Auth
      attr_accessor :app

      def initialize(app)
        self.app = app
      end

      def call(env)
        return app.call(env) unless metrics_path?(env)
        return app.call(env) unless config.is_auth_enabled?
        return app.call(env) if authorized?(env)

        unauthorized
      end

    private

      def metrics_path?(env)
        path = env.fetch("PATH_INFO")
        path == config.prometheus_metrics_path
      end

      def authorized?(env)
        header = env.fetch("HTTP_AUTHORIZATION", "")
        token = header[/Bearer (.*)/i, 1]

        token == config.application_id
      end

      def config
        Config.instance
      end

      def unauthorized
        [401, { "Content-Type" => "text/plain" }, %w[Unauthorized]]
      end
    end
  end
end
