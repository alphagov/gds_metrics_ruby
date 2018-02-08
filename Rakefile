task :units do
  system("bundle exec rspec --exclude-pattern 'spec/dummy/**/*'")
end

task :features do
  system("pushd spec/dummy && bundle exec rake && popd")
end

task default: [:units, :features]
