RSpec.describe GDS::Metrics::Gzip do
  class GzipFakeApp
    attr_accessor :body

    def call(_)
      [200, {}, [body]]
    end
  end

  let(:app) { GzipFakeApp.new }

  before do
    app.body = "really long body " * 100
  end

  subject { described_class.new(app) }

  let(:env) do
    {
      "PATH_INFO" => request_path,
      "HTTP_ACCEPT_ENCODING" => "gzip, deflate",
    }
  end

  context "/metrics" do
    let(:request_path) { "/metrics" }

    context "for a long body" do
      it "compresses response data" do
        _, _, body = subject.call(env)
        expect(body).to be_a(Rack::Deflater::GzipStream)
      end
    end

    context "for a short body" do
      before { app.body = "short body" }

      it "does not compress short bodies" do
        _, _, body = subject.call(env)
        expect(body).not_to be_a(Rack::Deflater::GzipStream)
      end
    end
  end

  context "/some-other-path" do
    let(:request_path) { "/some-other-path" }

    it "does not affect other responses from the app" do
      _, _, body = subject.call(env)
      expect(body).not_to be_a(Rack::Deflater::GzipStream)
    end
  end
end
