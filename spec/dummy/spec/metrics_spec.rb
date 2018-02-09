RSpec.describe "/metrics", type: :request do
  it "responds with a 200 status code" do
    get "/metrics"
    expect(response).to be_ok
  end
end
