RSpec.describe GDS::Metrics::Middleware do
  class MiddlewareFakeApp
    def call(_)
      [200, {}, []]
    end
  end

  let(:app) { MiddlewareFakeApp.new }
  let(:config) { GDS::Metrics::Config.instance }

  subject { described_class.new(app) }

  before do
    config.application_id = "app-123"
    config.use_basic_auth = true
  end

  let(:env) do
    {
      "REQUEST_METHOD" => "GET",
      "PATH_INFO" => "/metrics",
      "HTTP_AUTHORIZATION" => "Bearer wrong",
    }
  end

  it "authenticates the incoming request" do
    status, = subject.call(env)
    expect(status).to eq(401)

    env["HTTP_AUTHORIZATION"] = "Bearer app-123"

    status, = subject.call(env)
    expect(status).to eq(200)
  end
end
