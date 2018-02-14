## GDS Metrics

Instrument your web app to export Prometheus metrics.

### Overview

This gem can be added to your web application to capture metrics about how it's
performing. These metrics are exported in the [Prometheus](https://prometheus.io/)
format and exposed via an endpoint. If your app is Rails, the gem
[has a Railtie](https://github.com/alphagov/gds_metrics_ruby/blob/master/lib/gds_metrics/railtie.rb)
that hooks into the
[middleware stack](https://www.amberbit.com/blog/2011/07/13/introduction-to-rack-middleware/),
meaning very little setup is required.

### Setup

Add the gem to your Gemfile:

```ruby
gem 'gds_metrics'
```

Then run your app and visit `/metrics`.

If you're not using Rails, you'll also need to add `use GDS::Metrics::Middleware`.

### Custom metrics

By default, some metrics will be recorded like `http_request_duration_seconds`,
but you can record your own metrics, too. This might be things like how many
emails your system's sent, or how many users are signed up for your service.

The gem is built on top of the `prometheus_ruby_client`, so you can use the
[metrics it provides](https://github.com/prometheus/client_ruby#metrics) for
this.

### Configuring the path

You can configure the metrics path with an environment variable:

```
$ PROMETHEUS_METRICS_PATH=/my-path bundle exec rails s
```

### Authentication

If your app is running on the
[GOV.UK PaaS](https://docs.cloud.service.gov.uk/#technical-documentation-for-gov-uk-paas),
the metrics endpoint requires a bearer token. This bearer token is set to your
application's id. This can be found by running `cf apps`. Here's an example of a
request that passes a bearer token:

```
$ curl -H 'Authorization: Bearer my-app-id' https://myservice.cloudapps.digital
```

### Multi-process model

This gem handles the case where your application runs multiple processes to
handle web requests. This is typically the case in production, where you might
be using [Unicorn](https://github.com/blog/517-unicorn) or
[Puma](https://github.com/puma/puma). It writes a memory-mapped file to `/tmp`
to facilitate this.

You can set a different path with an environment variable:

```
$ MMAP_DIRECTORY=/somewhere/else bundle exec rails s
```
