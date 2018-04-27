RSpec.describe "the path converter in use", type: :request do
  before do
    get "/foo/101"
    get "/foo/102"
    get "/foo/103"
    get "/metrics"
  end

  it "returns metric names using the controller and action used to access the path" do
    expect(response.body).to include('path="foo#bar"')
  end

  it "doesn't include the specific calls made" do
    made_calls = %w(/foo/101 /foo/102 /foo/103)
    made_calls.each do |call|
      expect(response.body).not_to include("path=\"#{call}\"")
    end
  end

  it "leaves the path alone for requests made without an action or controller" do
    expect(response.body).to include('path="/metrics"')
  end
end
