module GDS
  module Metrics
    module Mmap
      def self.setup
        directory = Config.instance.mmap_directory
        Prometheus::Client.configuration.multiprocess_files_dir = directory
      end
    end
  end
end
