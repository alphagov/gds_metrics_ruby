RSpec.describe GDS::Metrics::Proxy do
  let(:prometheus_registry) { Prometheus::Client.registry }

  it "forwards methods to the prometheus registry by default" do
    expect(prometheus_registry).to receive(:counter)
      .with(:my_counter, "description of my counter")

    subject.counter(:my_counter, "description of my counter")
  end

  describe "#summary" do
    it "does not forward to the prometheus registry" do
      expect(prometheus_registry).not_to receive(:summary)
      subject.summary(:my_summary, "description of my summary")
    end

    it "returns a null summary that responds to #observe" do
      summary = subject.summary(:my_summary, "description of my summary")

      expect(summary).to be_a(described_class::NullSummary)
      expect { summary.observe }.not_to raise_error
    end
  end

  it "renames keys to match the latest official prometheus gem" do
    expect(prometheus_registry).to receive(:counter)
      .with(:http_server_requests_total, "description")

    expect(prometheus_registry).to receive(:counter)
      .with(:http_server_exceptions_total, "description")

    expect(prometheus_registry).to receive(:histogram)
      .with(:http_server_request_duration_seconds, "description")

    subject.counter(:http_requests_total, "description")
    subject.counter(:http_exceptions_total, "description")
    subject.histogram(:http_req_duration_seconds, "description")
  end
end
