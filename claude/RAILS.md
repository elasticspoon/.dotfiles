### Coding Guidelines

#### General

- Write concise, idiomatic Ruby code with accurate examples
- Follow Rails conventions and best practices
- Use descriptive variable and method names (e.g., user_signed_in?, calculate_total)
- Structure files according to Rails conventions (MVC, concerns, helpers, etc.)
- Avoid excessive use of complex Ruby and Rails features (inheritance hooks like
  `inherited`, method_missing)
- Prefer using service object with longer methods to contain business logic.

#### Common Patterns

- If a form url or controller redirect is to an action in the same controller,
  use a hash with the action name as the key e.g. `{ action: :new }`
- When making migrations, use `text` for all string fields; never use `string`
  or `varchar`

#### Naming Conventions

- Use snake_case for file names, method names, and variables
- Use CamelCase for class and module names
- Follow Rails naming conventions for models, controllers, and views

#### Ruby and Rails Usage

- Use Ruby 3.x features when appropriate (e.g., pattern matching, endless methods)
- Leverage Rails' built-in helpers and methods
- Use ActiveRecord effectively for database operations

#### Syntax and Formatting

- Follow the Ruby Style Guide (<https://rubystyle.guide/>)
- Use Ruby's expressive syntax (e.g., unless, ||=, &.)
- Prefer double quotes for strings
- Always strip whitespace at the end of lines and ensure a blank line exists at
  the end of the file

#### Controllers

- When adding new controllers or actions, don't forget to update the routes.rb
- Use `expect` syntax instead of `require`/`allow` for strong parameters:

  ```ruby
  # Good
  params.expect(user: [:name, :favorite_pie])

  # Bad
  params.require(:user).permit(:name, :favorite_pie)
  ```

- Unless parameters are reused more than once, assign strong parameters to a local variable rather than a method
- When linking or redirecting to an action in the same controller, use `url_for(action: "the_action")` instead of path helpers

#### View templates

- Use the custom form builder `FrontdoorForm` which contains helpers for structure bootstrap forms.
- When using `FrontdoorForm`, do not add Bootstrap classes like `form-label`/`form-control`/`form-select`; they're already added by the FrontdoorForm builder.
- Most simple form inputs will have this structure of `group`, `label`, `input`, and `errors`:

  ```
  <%= f.group(:first_name, class: "col-3") do %>
    <%= f.label :first_name, "First Name" %>
    <%= f.input :first_name %>
    <%= f.errors :first_name %>
  <% end %>
  ```

- When creating `select` tags, use `include_blank: "string"` instead of manually adding a blank option to the list of options.

#### Database Migrations

- Always create a migration using `bin/rails g migration <NAME>`. If a migration has been created in the current development feature branch, rollback the migration, edit it and then roll forward rather than creating a new migration.
- Use `text` for all string fields; never use `string` or `varchar`
- Use `datetime` instead of `timestamp`
- Assume that Boolean values should be nullable unless specified

#### Testing

- Write tests using RSpec. It's ok to put multiple assertions in the same example
- Use factories (FactoryBot) for test data generation
- Prefer real objects over mocks unless there is an external dependency like a third party API call. Use `instance_double` if necessary; never `double`
- Don't test declarative configuration. For validations, only test that it's not valid when the validation is violated. `shoulda-matchers` is not used.
- Test controllers behaviorally: assert on status code and/or data changes
- Use Timecop for time traveling

##### System Tests

- When writing System Tests, use `css_id(*)` and `css_class(*)` instead of `"#{dom_id(*)}"` `"#{dom_class(*)}"`
- Use Capybara async matchers and expectations and generally avoid asserting on `find` methods that may be flaky.

### Performance Optimization

- Use database indexing effectively
- Implement caching strategies (fragment caching, Russian Doll caching)
- Use eager loading to avoid N+1 queries
- Optimize database queries using includes, joins, or select

## When modifying Rails controllers

### Routes

When adding new controllers or actions, don't forget to update the [routes.rb](mdc:config/routes.rb)

### Strong Params

Use `expect` syntax instead of `require`/`allow`

```
# Bad
params.require(:user).permit(:name, :favorite_pie)

# Good
params.expect(user: [:name, :favorite_pie])
```

### Wizard flows

Controllers in the `Apply` namespace are part of a form wizard. Each controller represents a stage in the from wizard flow. The flow is implemented in [flowable.rb](mdc:app/controllers/concerns/flowable.rb) and the stages are declared in [base_controller.rb](mdc:app/controllers/apply/base_controller.rb). To redirect to the next stage of the flow, use `flow_next_path`.

### Same-controller paths and redirects

When linking or redirecting to an action in the same controller, always use `url_for(action: "the_action")` with implicit controller instead of a path helper:

```
#  Bad
my_controller_the_action_path

# Good
url_for(action: "the_action")
```

## Database migration rules

- The database is Postgres
- Use `text` for all string fields; never use `string` or `varchar`
- Use `datetime` instead of `timestamp`
- Assume that Boolean values should be nullable unless specified

# Rules for writing RSpec tests

- Write comprehensive tests using RSpec. It's ok to put multiple assertions in the same example.
- Use factories (FactoryBot) for test data generation.
- When writing System Tests. Use `css_id(*)` and `css_class(*)` instead of `"#{dom_id(*)}"` `"#{dom_class(*)}"`
- `shoulda-matchers` is not installed. Don't test declarative configuration. For validations, only test that it's not valid when the validation is violated.
- `rails-controller-testing` is not installed. Test controllers behaviorally: correct status code and/or model changes. Don't use `assigns` to inspect ivars.
