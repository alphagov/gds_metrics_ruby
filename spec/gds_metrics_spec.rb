RSpec.describe GDS::Metrics do
  it "configures the gem" do
    config = GDS::Metrics::Config.instance
    expect(config.prometheus_metrics_path).to eq("/metrics")
  end
end
