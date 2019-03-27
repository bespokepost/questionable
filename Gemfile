source 'http://rubygems.org'

ruby '>= 2.2'

# Declare your gem's dependencies in questionable.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# jquery-rails is used by the dummy application
gem 'jquery-rails'

# devise and activeadmin are used by the dummy application
gem 'devise'
gem 'activeadmin'

group :development, :test do
  gem 'autotest-rails'
  gem 'autotest-fsevent'  # Make autotest faster on OS X
  gem 'autotest-notification'  # show popup notices
  gem 'bundler-audit'
  gem 'test-unit'
end

group :test do
  gem 'codeclimate-test-reporter', "~> 1.0.0"
  gem 'pg' # Needed for CircleCI tests
  gem 'rspec_junit_formatter'
  gem 'simplecov'
end
