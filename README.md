## GDS Metrics

Instrument your web app to export [Prometheus](https://prometheus.io/) metrics.

### Overview

This gem can be added to your web app to capture metrics about how it's
performing. These metrics are served from an endpoint of your app and can be
scraped by Prometheus and turned into Grafana dashboards.

### Setup for Rails

1. Add the [latest version of the gem](https://rubygems.org/gems/gds_metrics) to
your Gemfile:

```ruby
gem 'gds_metrics', '~> x.x.x'
```

2. Install the gem: `bundle install`
3. Set an environment variable: `export PROMETHEUS_METRICS_PATH=/metrics`
4. Restart your rails server: `bundle exec rails server`
5. Visit any page of your app, e.g. [the index page](http://localhost:3000/)
6. Visit the metrics endpoint: [localhost:3000/metrics](http://localhost:3000/metrics)

You should see a page containing metrics like `http_req_duration_seconds`.

The gem is now set up correctly.

### Non-Rails apps

If you're not using Rails, the setup steps are the same but you'll also need to
add `GDS::Metrics::Middleware` as a
[Rack middleware](https://www.amberbit.com/blog/2011/07/13/introduction-to-rack-middleware/).
Refer to your framework's documentation for how to do this, e.g.
[Sinatra](http://sinatrarb.com/intro#Rack%20Middleware),
[Grape](https://github.com/ruby-grape/grape#using-custom-middleware).

### Running on the PaaS

The gem can be used with the [GOV.UK PaaS](https://www.cloud.service.gov.uk/).
You can set the environment variable with:

```bash
$ cf set-env your-app-name PROMETHEUS_METRICS_PATH /metrics
```

The metrics endpoint will automatically be protected with authentication.
Citizens will not be able to see your metrics.

### Adding custom metrics

This step is optional.

By default, common metrics will be recorded, but you can record your own
metrics, too. You might want to capture how many users are signed up for your
service or how many emails its sent.

The gem is built on top of the `prometheus_ruby_client`, so you can use the
[interface it provides](https://github.com/prometheus/client_ruby#metrics) for
this. There's more documentation on types of metric
[here](https://prometheus.io/docs/concepts/metric_types/).
