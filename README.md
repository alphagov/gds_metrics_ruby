# GDS metrics for Rails apps

GDS Metrics are in Alpha and these instructions are subject to change.

GDS Rails metrics enable your [Ruby][] web app to export performance data to [Prometheus][], you can add metrics to your app using this [Ruby gem][]. Once you’ve added the gem, metrics data is served from your app's metrics endpoint and is scraped by Prometheus. This data can be turned into performance dashboards using [Grafana][].

You can read more about the Reliability Engineering monitoring solution [here][].

## Before using GDS metrics

Before using GDS metrics you should have:

* created a Rails or [Rack][] app
* deployed it to [GOV.UK Platform as a Service (PaaS)][]

## How to install metrics for Rails apps

To use GDS metrics you must:

1. Add the [latest version of the gem](https://rubygems.org/gems/gds_metrics) to your Gemfile, and run it using the command line, for example:

    ```ruby gem 'gds_metrics', '~> x.x.x'```

2. Run the following command to install the gem:

    ```bundle install```

3. Set an environment variable so Prometheus can discover your app’s metrics, for example:

    ```export PROMETHEUS_METRICS_PATH=/metrics```

4. Restart your Rails server by running:  

    ```bundle exec rails server```

5. Visit any page of your app (for example [the index page][]) to generate some site traffic

6. Visit the metrics endpoint at localhost:3000/metrics to check if the gem was set up correctly. If it's set up correctly, you will see a page containing some metrics (for example http_req_duration_seconds).

If you're not using Rails, you'll also need to add GDS::Metrics::Middleware as [Rack middleware][] before running your Rails server. You’ll also need to refer to your framework's documentation, for example [Sinatra][] or [Grape][] middleware.

## Running on GOV.UK Platform as a Service (PaaS)

The install steps for GDS Metrics only apply to the Rails server on your local machine. If your app runs on [PaaS][], you'll need to set the [environment variable][] by running:

```$ cf set-env your-app-name PROMETHEUS_METRICS_PATH /metrics```

Where `your-app-name` is the name of your app.

Your metrics endpoint will now be available in your production environment. Citizens won’t see your metrics in production as this endpoint is automatically protected with authentication.

The PaaS documentation has information on how you can [deploy a basic Ruby on Rails app][]. You can also read the official Cloud Foundry guide which has detailed information on [deploying Ruby on Rails apps][].

## How to setup extended metrics

While common metrics are recorded by default, you can also:

* record your own metrics such as how many users are signed up for your service, or how many emails it's sent
* use the Prometheus interface to set your own metrics as the metrics Ruby gem is built on top of the [Prometheus Ruby Client][]

You can read more about the different types of metrics available in the [Prometheus documentation][].

## Contributing

GDS Reliability Engineering welcome contributions. We'd appreciate it if you write tests with your changes and document them where appropriate, this will help us review them quickly.

## Licence

This project is licensed under the [MIT License][].



[Ruby]: http://rubyonrails.org/
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
[Prometheus documentation]: https://prometheus.io/docs/concepts/metric_types/
[MIT License]: https://github.com/alphagov/gds_metrics_ruby/blob/master/LICENSE
