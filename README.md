# GDS metrics for Ruby apps

GDS Metrics are in Alpha and these instructions are subject to change.

GDS Ruby metrics enable your [Ruby][] web app to export performance data to [Prometheus][], you can add metrics to your app using this [Ruby gem][].

This gem is a thin wrapper around gitlab's [prometheus-client-mmap][] that:

* adds a [railtie][] for easy configuration for [Rails][] apps
* fixes label naming so it's consistent with the official [Prometheus Ruby Client][]
* changes url path labels from unique paths to their Rails controller and action if the url path matches a route. For example - `blogs/8`, `blogs/9` => `blogs#view`
* protects your `/metrics` endpoint with basic HTTP authentication for apps deployed to GOV.UK PaaS

Once you’ve added the gem, metrics data is served from your app's metrics endpoint and is scraped by Prometheus. This data can be turned into performance dashboards using [Grafana][].

You can read more about the Reliability Engineering monitoring solution [here][].

## Before using GDS metrics

Before using GDS metrics you should have:

* created a [Rails][] or [Rack][] app
* deployed it to [GOV.UK Platform as a Service (PaaS)][]

## How to install metrics for Rails apps

To use GDS metrics you must:

1. Add the [latest version of the gem](https://rubygems.org/gems/gds_metrics) to your Gemfile, for example:

    ```gem 'gds_metrics'```

2. Run the following command to install the gem:

    ```bundle install```

3. Restart your Rails server by running:

    ```bundle exec rails server```

4. Visit any page of your app (for example [the index page][]) to generate some site traffic

5. Visit the metrics endpoint at `/metrics` to check if the gem was set up correctly. If it's set up correctly, you will see a page containing some metrics (for example `http_req_duration_seconds`).

If you're not using Rails, you'll also need to add GDS::Metrics::Middleware as [Rack middleware][] before running your Rails server. You’ll also need to refer to your framework's documentation, for example [Sinatra][] or [Grape][] middleware.

## Running on GOV.UK Platform as a Service (PaaS)

When running on PaaS, citizens won’t see your metrics in production as this endpoint is automatically protected with authentication.

The PaaS documentation has information on how you can [deploy a basic Ruby on Rails app][]. You can also read the official Cloud Foundry guide which has detailed information on [deploying Ruby on Rails apps][].

## Testing

The test suite can be run in full using `bundle exec rake`, this includes unit and integration tests as well as a code style check using the [Govuk Linter][].

Individual unit tests in `/spec/gds_metrics` can be run using `rspec path/to/test.rb`

Because of the need to test the apps integration with rails there is a dummy Rails app within `/spec`. This app is run from within the test suite and integration tests are then executed against it. At the moment these tests cannot be run individually but can be run separately from the unit tests by running `pushd spec/dummy && bundle exec rake && popd`

## Optional configuration

You can change the path for serving metrics (by default `/metrics`) by setting the `PROMETHEUS_METRICS_PATH` [environment variable][].

If you are running `blue-green` deployments through a cf plugin like [autopilot][] it is advisable to disable the basic auth on the `\metrics` endpoint and use [IP whitelisting][] by setting the `METRICS_BASIC_AUTH` [environment variable][] to `false`. This will prevent gaps in metrics during deployment.

## How to setup extended metrics

While common metrics are recorded by default, you can also:

* record your own metrics such as how many users are signed up for your service, or how many emails it's sent
* use the Prometheus interface to set your own metrics as the metrics Ruby gem is built on top of [prometheus-client-mmap][]

You can read more about the different types of metrics available in the [Prometheus documentation][].

## Contributing

GDS Reliability Engineering welcome contributions. We'd appreciate it if you write tests with your changes and document them where appropriate, this will help us review them quickly.

## Licence

This project is licensed under the [MIT License][].



[Ruby]: https://www.ruby-lang.org/en/
[Rails]: http://rubyonrails.org/
[railtie]: http://api.rubyonrails.org/classes/Rails/Railtie.html
[Prometheus]: https://prometheus.io/
[Ruby gem]: https://rubygems.org/gems/gds_metrics
[Grafana]: https://grafana.com/
[here]: https://reliability-engineering.cloudapps.digital/#reliability-engineering
[Rack]: https://rack.github.io/
[GOV.UK Platform as a Service (PaaS)]: https://www.cloud.service.gov.uk/
[the index page]: http://localhost:3000/
[Rack middleware]: https://www.amberbit.com/blog/2011/07/13/introduction-to-rack-middleware/
[Sinatra]: http://sinatrarb.com/intro#Rack%20Middleware
[Grape]: https://github.com/ruby-grape/grape#using-custom-middleware
[PaaS]: https://www.cloud.service.gov.uk/
[environment variable]: https://docs.cloud.service.gov.uk/#environment-variables
[deploy a basic Ruby on Rails app]: https://docs.cloud.service.gov.uk/#deploy-a-ruby-on-rails-app
[deploying Ruby on Rails apps]: http://docs.cloudfoundry.org/buildpacks/ruby/gsg-ror.html
[Prometheus Ruby Client]: https://github.com/prometheus/client_ruby#metrics
[prometheus-client-mmap]: https://gitlab.com/gitlab-org/prometheus-client-mmap
[Prometheus documentation]: https://prometheus.io/docs/concepts/metric_types/
[MIT License]: https://github.com/alphagov/gds_metrics_ruby/blob/master/LICENSE
[Govuk Linter]: https://github.com/alphagov/govuk-lint
[autopilot]: https://github.com/contraband/autopilot
[IP whitelisting]: https://reliability-engineering.cloudapps.digital/manuals/monitor-paas-app-with-prometheus.html#ip-whitelist-your-app-metrics-endpoint
