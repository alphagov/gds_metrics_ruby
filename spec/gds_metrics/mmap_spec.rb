RSpec.describe GDS::Metrics::Mmap do
  let(:gds_metrics_config) { GDS::Metrics::Config.instance }
  let(:prometheus_config) { Prometheus::Client.configuration }

  describe ".setup" do
    it "sets the directory of the memory-mapped files" do
      gds_metrics_config.mmap_directory = "/something"
      subject.setup
      expect(prometheus_config.multiprocess_files_dir).to eq("/something")
    end
  end

  describe ".clean" do
    let(:tmp_dir) { Dir.mktmpdir }
    before { gds_metrics_config.mmap_directory = tmp_dir }

    it "removes memory-mapped files from the directory" do
      counter_db = "#{tmp_dir}/counter_1234.db"
      other_file = "#{tmp_dir}/some_other_file.csv"

      FileUtils.touch(counter_db)
      FileUtils.touch(other_file)

      subject.clean

      expect(File.exist?(counter_db)).to eq(false)
      expect(File.exist?(other_file)).to eq(true)
    end
  end
end
