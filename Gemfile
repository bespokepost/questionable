source 'https://rubygems.org'

ruby '>= 2.2'

# Declare your gem's dependencies in questionable.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Devise is needed for creating users for the answer spec
gem 'devise'
gem 'jquery-rails'

group :development, :test do
  gem 'bundler-audit'
  gem 'test-unit'
end

group :test do
  # Code coverage, See: https://github.com/colszowka/simplecov/issues/281
  gem 'codeclimate-test-reporter', "~> 1.0.0"
  gem 'pg' # Needed for CircleCI tests
  gem 'rspec_junit_formatter'
  gem 'simplecov'
end
