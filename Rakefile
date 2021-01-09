# frozen_string_literal: true

require_relative "config/application"

if Rails.env.development? || Rails.env.test?
  require "bundler/audit/task"
  Bundler::Audit::Task.new

  require "rubocop/rake_task"
  RuboCop::RakeTask.new

  require "haml_lint/rake_task"
  HamlLint::RakeTask.new

  task("yarn:audit") do
    sh("yarn audit")
  end

  task(:brakeman) do
    sh("bundle exec brakeman")
  end

  task(:stylelint) do
    sh("yarn stylelint")
  end

  task(
    lint: [
      "yarn:install",
      "yarn:audit",
      "bundle:audit",
      :brakeman,
      :rubocop,
      :haml_lint,
      :stylelint,
    ],
  )

  task(default: [:lint, :spec])
end

Rails.application.load_tasks
