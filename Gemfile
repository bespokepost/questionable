source "http://rubygems.org"

# Declare your gem's dependencies in questionable.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# jquery-rails is used by the dummy application
gem "jquery-rails"

# devise and activeadmin are used by the dummy application
gem 'devise'
gem 'activeadmin'

group :assets do
  gem 'sass-rails'
end

group :development, :tests do
  gem 'autotest-rails'
  gem 'autotest-fsevent'  # Make autotest faster on OS X
  gem 'autotest-notification'  # show popup notices
  gem 'test-unit'
end
