module GDS
  module Metrics
    class Railtie < Rails::Railtie
      initializer "gds_metrics.use_middleware" do |app|
        app.middleware.use GDS::Metrics::Middleware
      end
    end
  end
end
