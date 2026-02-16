# CLAUDE.md - Project Guidelines for Justice.Garden (SJFAQ)

This file contains essential information about project conventions, patterns, and guidelines for AI-assisted development.

## Project Overview

Justice.Garden (codename: SJFAQ) is a Rails web application for managing questions and answers with user authentication and role-based access control.

## Tech Stack

- **Ruby**: 4.0.1
- **Rails**: 8.1.0
- **Node.js**: 24.13.0
- **Database**: PostgreSQL 10.18
- **Background Jobs**: Sidekiq with ActiveJob
- **Testing**: RSpec with 100% code coverage requirement
- **Frontend**: HAML templates, SCSS, Webpack/Webpacker, Turbolinks

## Code Style Conventions

### Ruby/Rails

- **Frozen string literals**: Required at top of every file: `# frozen_string_literal: true`
- **String quotes**: Use double quotes for strings, double quotes in interpolation
- **Trailing commas**: Required in multi-line constructs
- **Symbol arrays**: Use bracket notation `[:admin, :viewer]` not `%i[admin viewer]`
- **Line length**: 80 characters maximum (auto-correct enabled)
- **Strong parameters**: Use `params.expect(question: [:text])` syntax
- **Method parentheses**: Not required for Rails DSL methods (`has_many`, `validates`, etc.)

### Controllers

- Keep controllers thin with minimal logic
- Authentication required by default via `before_action(:authenticate_user)`
- Use `render(locals: { ... })` to pass variables to views
- Successful operations redirect to `root_path`
- Use flash messages for user feedback

### Models

- Minimal validation - rely on database constraints
- Use enums: `enum :role, { admin: "admin", viewer: "viewer" }`
- Use `dependent: :destroy` to prevent orphaned records
- Override `find` and `find_by` to return Null Objects where appropriate

### Views

- **HAML only** - no ERB
- Use `current_user.logged_in?` for conditional rendering
- Use `link_to` helper with method parameter for non-GET requests
- Render flash messages from shared loop

### Database

- PostgreSQL enums for type columns
- Foreign key constraints enforced
- Unique indexes on business keys
- ActionText integration for rich text editing

## Architectural Patterns

### Null Object Pattern

The project uses the Null Object pattern extensively:

- `NullUser` class provides default behavior for unauthenticated users
- Model methods override `find` and `find_by` to return NullUser instead of raising exceptions
- Eliminates nil checks throughout the application

Example:
```ruby
class User
  def self.find(...)
    super
  rescue ActiveRecord::RecordNotFound
    NullUser.new
  end
end
```

### Resource Organization

- Use singular resources for one-per-user resources: `resource :account`, `resource :session`
- Use nested shallow resources for parent-child relationships
- Background jobs use `CallableJob` abstraction for passing callable objects to Sidekiq

## Testing Requirements

### Coverage

- **100% code coverage required** via SimpleCov
- Build fails if coverage drops below 100%

### Test Organization

```
/spec
  ├── models/           # Model specs with Shoulda matchers
  ├── controllers/      # Controller specs
  ├── system/          # Integration tests with Capybara
  ├── jobs/            # Background job specs
  ├── helpers/         # View helper specs
  └── support/         # Custom matchers and helpers
```

### Test Patterns

- Use Shoulda matchers for associations/validations
- System tests use `SystemHelpers` module for common actions
- Custom matchers available: `have_error`, `have_flash`, `delete_record`, `change_record`
- Use i18n via `t()` for translatable text in tests

### System Test Helpers

Common helpers in `spec/support/system_helpers.rb`:
- `user_params`: Default test user credentials
- `create_and_sign_in_admin`, `create_and_sign_in_user`: User setup shortcuts
- `add_question`, `update_question`: Capybara action sequences
- `add_answer`, `update_answer`: Rich text editing sequences

Example:
```ruby
create_and_sign_in_admin
add_question("What is the meaning of life?")
```

## Linting & Code Quality

### RuboCop

- Enabled by default with strict enforcement
- Plugins: rubocop-capybara, rubocop-rails, rubocop-rspec, rubocop-rspec_rails
- Auto-correct enabled for most cops
- Run with: `bundle exec rubocop`

### Stylelint

- BEM pattern validation enabled
- Property sort order follows SMACSS methodology
- Run with: `pnpm stylelint`

### Other Tools

- **Haml-lint**: Run with `bundle exec haml-lint`
- **Brakeman**: Security scanning with `bundle exec brakeman`
- **Bundler-audit**: Dependency vulnerability scanning with `bundle exec rails bundle:audit`

## Development Workflow

### Guard

Guard is configured for auto-running tests and linters:
- RSpec auto-runner with Spring
- Haml-lint auto-runner
- RuboCop auto-runner with auto-fix
- Halts on first failure

Start Guard with: `bundle exec guard`

### Before Committing

All of these must pass:
1. RSpec tests with 100% coverage
2. RuboCop with no offenses
3. Stylelint with no errors
4. Haml-lint with no errors
5. Brakeman with no security warnings
6. Bundler-audit with no vulnerable dependencies

### CI/CD Pipeline (CircleCI)

The CircleCI pipeline runs:
1. Bundler audit
2. Database setup
3. Brakeman security scan
4. Stylelint
5. RuboCop
6. Haml-lint
7. RSpec with coverage

## Common Tasks

### Running Tests

```bash
# All tests
bundle exec rspec

# With coverage
COVERAGE=true bundle exec rspec

# Specific file
bundle exec rspec spec/models/user_spec.rb

# With Guard (auto-run on file changes)
bundle exec guard
```

### Adding a New Model

1. Generate migration with proper foreign keys and constraints
2. Add model with minimal validations
3. Add associations with `dependent: :destroy` where appropriate
4. Override `find`/`find_by` if Null Object pattern applies
5. Write model specs with Shoulda matchers
6. Ensure 100% test coverage

### Adding a New Feature

1. Write system/integration tests first
2. Implement controllers (keep thin)
3. Create HAML views
4. Add SCSS following BEM pattern
5. Run all linters and tests
6. Verify 100% coverage maintained

## Security Notes

- `has_secure_password` used for authentication (BCrypt)
- AdminConstraint protects Sidekiq Web dashboard
- CSRF protection enabled
- Strong parameters enforced
- Regular dependency audits via Bundler-audit

## File Locations

- **Models**: `/app/models` (Null Objects in `/app/models/nulls`)
- **Controllers**: `/app/controllers`
- **Views**: `/app/views` (HAML only)
- **Stylesheets**: `/app/assets/stylesheets` (SCSS)
- **JavaScript**: `/app/javascript/packs` (Webpack entry points)
- **Tests**: `/spec`
- **Config**: `/config`
- **Background Jobs**: `/app/jobs`

## Important Files

- `.rubocop.yml`: Ruby style configuration
- `.stylelintrc.yml`: CSS/SCSS linting configuration
- `.haml-lint.yml`: HAML linting configuration
- `Guardfile`: Auto-run configuration
- `.circleci/config.yml`: CI/CD pipeline
- `spec/spec_helper.rb`: RSpec configuration
- `spec/support/`: Custom test helpers and matchers

## Don't

- Don't use ERB templates (HAML only)
- Don't add validations that duplicate database constraints
- Don't use single quotes for strings
- Don't skip the linters or tests
- Don't commit code below 100% test coverage
- Don't use `%i[]` or `%w[]` for arrays (use bracket notation)
- Don't add code without tests

## Do

- Use Null Object pattern for optional associations
- Keep controllers thin
- Use database constraints over validations
- Write system tests for user-facing features
- Use custom matchers and helpers in tests
- Run Guard during development for fast feedback
- Use frozen string literals
- Follow BEM pattern for CSS class names
