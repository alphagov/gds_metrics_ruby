module GDS
  module Metrics
    class Uptime
      def initialize(app)
        @app = app
      end

      def call(env)
        self.class.set_uptime
        @app.call(env)
      end

      class << self
        def set_uptime
          uptime_seconds.set({}, current_time - boot_time)
        end

        def uptime_seconds
          @uptime_seconds ||= prometheus.gauge(:uptime_seconds,
            "The number of seconds the application has been running.",
          )
        end

        def boot_time
          @boot_time ||= Time.now
        end

        def current_time
          Time.now
        end

        def prometheus
          @prometheus ||= Prometheus::Client.registry
        end
      end

      # set the boot_time when the class is evaluated
      boot_time
    end
  end
end
