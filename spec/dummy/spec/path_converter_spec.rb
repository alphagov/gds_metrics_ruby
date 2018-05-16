RSpec.describe "the path converter in use", type: :request do
  before do
    Rails.application.config.action_dispatch.show_exceptions = true
    get "/example/101"
    post "/example/101"
    get "/metrics"
  end

  it "returns metric names using the controller and action used to access the path" do
    expect(response.body).to include('controller="example#get"')
    expect(response.body).to include('controller="example#post"')
  end

  it "doesn't include the specific calls made" do
    expect(response.body).not_to include('controller="example#get/101"')
  end

  it "leaves the path alone for requests made without an action or controller" do
    expect(response.body).to include('path="/metrics"')
  end

  it "sends an empty controller label when hitting a 404" do
    expect { get "/something_to_404" }.to raise_error(ActionController::RoutingError)
    get "/metrics"
    expect(response.body).to include('controller="",code="404"')
  end
end
