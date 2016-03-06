if ENV['GENERATE_REPORTS'] == 'true'
  require 'ci/reporter/rake/rspec'

  desc "run test on jenkins"
  task :run_test => ['db:migrate', 'ci:setup:rspec'] do
    Rake::Task["spec"].invoke
  end
end
