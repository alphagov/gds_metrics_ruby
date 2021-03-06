module GDS
  module Metrics
    class PathConverter
      def self.convert_rails_path_to_route(path)
        # Convert a path to it's controller and action so we minimise the number of unique timeseries
        # in the case of IDs/variables in paths. Fallback to path if no route found
        route = Rails.application.routes.recognize_path(path)
        "#{route[:controller]}\##{route[:action]}"
      rescue ActionController::RoutingError
        nil
      end
    end
  end
end
