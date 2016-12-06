require 'bundler'
Bundler.require(:development)

SimpleCov.start do
  add_filter "/spec/"
  add_filter "/vendor/"

  minimum_coverage 100
  refuse_coverage_drop
end if ENV["coverage"]

require_relative '../lib/http_stub_example_consumer'

require_relative 'support/lib/http_stub_example_consumer/resource_fixture'
require_relative 'support/resource_api_stub'

RSpec.configure { |config| config.order = "random" }
