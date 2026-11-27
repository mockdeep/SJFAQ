# frozen_string_literal: true

require_relative "support/coverage"

ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../config/environment", __dir__)

if Rails.env.production?
  abort("The Rails environment is running in production mode!")
end

require "rspec/rails"

require_relative "support/assets"
require_relative "support/capybara"
require_relative "support/factory_bot"
require_relative "support/helpers"
require_relative "support/matchers"
require_relative "support/mocks"
require_relative "support/shoulda_matchers"
require_relative "support/system_helpers"
require_relative "support/webmock"

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_paths = [Rails.root.join("/spec/fixtures")]

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.render_views

  config.include(SystemHelpers, type: :system)

  config.expect_with(:rspec) do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # Prevents stubbing a method that does not exist on a real object.
  config.mock_with(:rspec) do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.filter_run_when_matching(:focus)

  config.example_status_persistence_file_path = "spec/examples.txt"

  config.raise_errors_for_deprecations!
  config.raise_on_warning = true
  config.disable_monkey_patching!

  config.default_formatter = "doc" if config.files_to_run.one?

  config.profile_examples = 10

  config.order = :random

  Kernel.srand(config.seed)
end
