RSpec.describe GDS::Metrics do
  it "checks the test suite is set up for unit tests" do
    expect(GDS::Metrics::VERSION).to eq("0.0.1")
  end
end
