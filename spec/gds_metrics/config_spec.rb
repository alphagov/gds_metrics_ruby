RSpec.describe GDS::Metrics::Config do
  subject { described_class.instance }

  it "provides a convenience method" do
    GDS::Metrics.configure do |config|
      config.application_id = "foo"
    end

    expect(subject.application_id).to eq("foo")
  end

  describe "#populate_from_env" do
    before do
      allow(ENV).to receive(:fetch).and_call_original
    end

    it "sets sensible defaults" do
      subject.populate_from_env

      expect(subject.application_id).to be_nil
      expect(subject.prometheus_metrics_path).to eq("/metrics")
      expect(subject.mmap_directory).to eq("/tmp")
      expect(subject.use_basic_auth).to eq(true)
    end

    def stub_env(key, value)
      allow(ENV).to receive(:fetch).with(key, anything).and_return(value)
    end

    it "can set the application id from env" do
      stub_env("VCAP_APPLICATION", { "application_id" => "something" }.to_json)

      subject.populate_from_env
      expect(subject.application_id).to eq("something")
    end

    it "can set the prometheus metrics path from env" do
      stub_env("PROMETHEUS_METRICS_PATH", "/prometheus")

      subject.populate_from_env
      expect(subject.prometheus_metrics_path).to eq("/prometheus")
    end

    it "can set the mmap directory from env" do
      stub_env("MMAP_DIRECTORY", "/something")

      subject.populate_from_env
      expect(subject.mmap_directory).to eq("/something")
    end

    it "enables auth if application id is present" do
      stub_env("VCAP_APPLICATION", { "application_id" => "something" }.to_json)

      subject.populate_from_env
      expect(subject.is_auth_enabled?).to eq(true)
    end
  end
end
