# frozen_string_literal: true

require_relative "config/application"

if Rails.env.local?
  require "bundler/audit/task"
  Bundler::Audit::Task.new

  require "rubocop/rake_task"
  RuboCop::RakeTask.new

  desc("Audit JS dependencies for vulnerabilities")
  task("pnpm:audit") do
    sh("pnpm audit")
  end

  desc("Scan for security vulnerabilities")
  task(:brakeman) do
    sh("bundle exec brakeman")
  end

  desc("Lint stylesheets")
  task(:stylelint) do
    sh("pnpm stylelint")
  end

  task(
    lint: [
      "pnpm:audit",
      "bundle:audit",
      :brakeman,
      :rubocop,
      :stylelint,
    ],
  )

  task(default: [:lint, :spec])
end

Rails.application.load_tasks
