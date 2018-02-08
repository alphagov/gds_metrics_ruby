class HelloController < ApplicationController
  def hello
    render plain: "GDS Metrics Version: #{GDS::Metrics::VERSION}"
  end
end
