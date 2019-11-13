task :clean do
  require "gds_metrics"
  GDS::Metrics::Mmap.clean
  puts "Cleaned up mmap directory"
end

task :units do
  system("bundle exec rspec --exclude-pattern 'spec/dummy/**/*'")
end

task :features do
  system("pushd spec/dummy && bundle exec rake && popd")
end

task :lint do
  system("rubocop")
end

task default: %i(clean units features lint)
