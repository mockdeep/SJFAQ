# frozen_string_literal: true

if ENV["COVERAGE"]
  require "simplecov"
  SimpleCov.start("rails") { enable_coverage(:branch) }

  SimpleCov.minimum_coverage(branch: 92, line: 63)
end
