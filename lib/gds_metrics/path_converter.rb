module GDS
  module Metrics
    class PathConverter
      def self.convert_rails_path_to_route(path)
        # Convert a path to it's controller and action so we minimise the number of unique timeseries
        # in the case of IDs/variables in paths. Fallback to path if no route found
        route = Rails.application.routes.recognize_path(path)
        controller_action = "#{route[:controller]}\##{route[:action]}"
        return controller_action unless [nil, ""].include?(controller_action)
        path
      rescue ActionController::RoutingError
        nil
      end
    end
  end
end
