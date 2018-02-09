task :units do
  system("bundle exec rspec --exclude-pattern 'spec/dummy/**/*'")
end

task :features do
  system("pushd spec/dummy && bundle exec rake && popd")
end

task :lint do
  system("govuk-lint-ruby")
end

task default: %i(units features lint)
