module GDS
  module Metrics
    module Mmap
      class << self
        def setup
          directory = Config.instance.mmap_directory
          Prometheus::Client.configuration.multiprocess_files_dir = directory
        end

        def clean
          directory = Config.instance.mmap_directory

          Dir.glob("#{directory}/*").each do |path|
            next unless database_file?(path)

            FileUtils.rm(path)
          end
        end

      private

        def database_file?(path)
          path.end_with?(".db") && METRIC_TYPES.any? { |t| path.include?(t) }
        end

        METRIC_TYPES = %w(counter histogram summary).freeze
      end
    end
  end
end
