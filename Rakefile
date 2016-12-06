require 'bundler'
Bundler.require(:default, :development)

require 'http_server_manager/rake/task_generators'

HttpServerManager.pid_dir = File.expand_path('../tmp/pids', __FILE__)
HttpServerManager.log_dir = File.expand_path('../tmp/logs', __FILE__)

require_relative 'lib/http_stub_example_consumer/server'

namespace :consumer do

  HttpServerManager::Rake::ServerTasks.new(HttpStubExampleConsumer::Server.new)

  desc "Verifies the consumer starts & stops successfully"
  task lifecycle_test: %w{ consumer:start consumer:stop }

end

begin

  require 'rubocop/rake_task'
  require 'rspec/core/rake_task'
  require 'http_server_manager/rake/task_generators'

  desc "Removes generated artefacts"
  task :clobber do
    %w{ coverage pkg tmp }.each { |dir| rm_rf dir }
    rm Dir.glob("**/coverage.data"), force: true
    puts "Clobbered"
  end

  namespace :metrics do

    RuboCop::RakeTask.new(:rubocop) { |task| task.fail_on_error = true }

  end

  desc "Performs source code metrics analysis"
  task metrics: "metrics:rubocop"

  namespace :stub do

    desc "Starts the example stub"
    task :start do
      sh "docker-compose --file docker-compose-stub.yml up --build --force-recreate -d"
      Wait.until_true!(description: "stub container is available") do
        HTTParty.get("http://localhost:5000/http_stub/status").body == "Initialized"
      end
    end

    desc "Stops the example stub"
    task :stop do
      sh "docker-compose --file docker-compose-stub.yml down"
    end

  end

  namespace :servers do

    desc "Starts stub and consumer"
    task start: %w{ stub:start consumer:start }

    desc "Stops stub and consumer"
    task stop: %w{ stub:stop consumer:stop }

  end

  desc "Exercises unit tests"
  ::RSpec::Core::RakeTask.new(:unit_test) do |task|
    task.exclude_pattern = "spec/acceptance/**{,/*/**}/*_spec.rb"
  end

  desc "Exercises unit tests and manages dependencies"
  task unit: "stub:start" do
    begin
      Rake::Task["unit_test"].invoke
    ensure
      Rake::Task["stub:stop"].invoke
    end
  end

  desc "Exercises specifications with coverage analysis"
  task :coverage => "coverage:generate"

  namespace :coverage do

    desc "Generates specification coverage results"
    task :generate do
      ENV["coverage"] = "enabled"
      Rake::Task[:unit].invoke
      sh "bundle exec codeclimate-test-reporter" if ENV["CODECLIMATE_REPO_TOKEN"]
    end

    desc "Shows specification coverage results in browser"
    task :show do
      begin
        Rake::Task["coverage:generate"].invoke
      ensure
        `open tmp/coverage/index.html`
      end
    end

  end

  namespace :ci do

    task :validate do
      print " Travis CI Validation ".center(80, "*") + "\n"
      result = `travis-lint #{::File.expand_path('../.travis.yml', __FILE__)}`
      puts result
      print "*" * 80+ "\n"
      raise "Travis CI validation failed" unless $?.success?
    end

  end

  task default: %w{ clobber metrics coverage consumer:lifecycle_test }

  task pre_commit: %w{ clobber metrics coverage:show consumer:lifecycle_test ci:validate }

rescue LoadError
  # Build pipeline tasks are optional - not required to start consumer
end

