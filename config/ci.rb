# frozen_string_literal: true

# Run using bin/ci

CI.run do
  step("Security: Gem audit", "bin/bundler-audit")
  step("Security: JS audit", "pnpm audit")
  step(
    "Security: Brakeman",
    "bin/brakeman --quiet --no-pager --exit-on-warn --exit-on-error",
  )

  step("Style: TypeScript", "pnpm tscheck")
  step("Style: ESLint", "pnpm eslint")
  step("Style: Stylelint", "pnpm stylelint")
  step("Style: Ruby", "bin/rubocop")

  step("Tests: JS", "pnpm vitest run")
  step("Tests: RSpec", "env COVERAGE=true bin/rspec")
end
