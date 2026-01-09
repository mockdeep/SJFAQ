# frozen_string_literal: true

require "spec_helper"
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../config/environment", __dir__)

if Rails.env.production?
  abort("The Rails environment is running in production mode!")
end

require "rspec/rails"

Rails.root.glob("spec/support/**/*.rb").each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_paths = [Rails.root.join("/spec/fixtures")]

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.render_views

  config.include(SystemHelpers, type: :system)
end
