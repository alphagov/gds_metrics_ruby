RSpec.describe GDS::Metrics::Mmap do
  let(:gds_metrics_config) { GDS::Metrics::Config.instance }
  let(:prometheus_config) { Prometheus::Client.configuration }

  it "sets the directory of the memory-mapped file" do
    gds_metrics_config.mmap_directory = "/something"
    subject.setup
    expect(prometheus_config.multiprocess_files_dir).to eq("/something")
  end
end
