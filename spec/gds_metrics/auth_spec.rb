RSpec.describe GDS::Metrics::Auth do
  class AuthFakeApp
    def call(_)
      [200, {}, []]
    end
  end

  let(:app) { AuthFakeApp.new }
  let(:config) { GDS::Metrics::Config.instance }

  before do
    config.application_id = "app-123"
    config.auth_enabled = true
  end

  subject { described_class.new(app) }

  let(:request_path) { "/metrics" }
  let(:request_token) { "app-123" }

  let(:request_env) do
    if request_token
      { "PATH_INFO" => request_path, "Authorization" => "Bearer #{request_token}" }
    else
      { "PATH_INFO" => request_path }
    end
  end

  context "when the path is not /metrics" do
    let(:request_path) { "/index" }
    let(:request_token) { nil }

    it "responds with 200" do
      status, = subject.call(request_env)
      expect(status).to eq(200)
    end
  end

  context "when the path is /metrics" do
    context "when auth is disabled" do
      before { config.auth_enabled = false }

      it "responds with 200" do
        status, = subject.call(request_env)
        expect(status).to eq(200)
      end
    end

    context "when auth is enabled" do
      context "when the bearer token matches" do
        let(:env) { { "Authorization" => "Bearer app-123" } }

        it "responds with 200" do
          status, = subject.call(request_env)
          expect(status).to eq(200)
        end
      end

      context "when the bearer token does not match" do
        let(:request_token) { "wrong" }

        it "responds with 401" do
          status, = subject.call(request_env)
          expect(status).to eq(401)
        end
      end
    end
  end
end
