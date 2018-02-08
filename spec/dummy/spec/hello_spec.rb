RSpec.describe "Hello", type: :request do
  it "checks the test suite is set up for feature tests" do
    get "/"
    expect(response.body).to eq("GDS Metrics Version: 0.0.1")
  end
end
