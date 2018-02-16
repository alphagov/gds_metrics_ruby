RSpec.describe "/metrics", type: :request do
  it "responds with a 200 status code" do
    get "/metrics"
    expect(response).to be_ok
  end

  it "returns metric names from a pre-defined set" do
    get "/metrics"

    # TODO: trigger an exception

    expect(unique_metric_names).to eq(%w(
      http_server_request_duration_seconds_bucket
      http_server_request_duration_seconds_count
      http_server_request_duration_seconds_sum
      http_server_requests_total
    ))
  end

  def unique_metric_names
    response.body
      .split("\n")
      .reject { |l| l.start_with?("#") }
      .map { |l| l.split("{").first }
      .uniq.sort
  end
end
