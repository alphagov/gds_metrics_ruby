RSpec.describe GDS::Metrics::Uptime do
  class UptimeFakeApp
    def call(_)
      [200, {}, []]
    end
  end

  let(:app) { UptimeFakeApp.new }
  subject { described_class.new(app) }

  it "sets the uptime since application boot" do
    allow(described_class).to receive(:boot_time).and_return(100)

    allow(described_class).to receive(:current_time).and_return(103)
    expect(described_class.uptime_seconds).to receive(:set).with({}, 3)
    subject.call({})

    allow(described_class).to receive(:current_time).and_return(105)
    expect(described_class.uptime_seconds).to receive(:set).with({}, 5)
    subject.call({})
  end
end
