require 'stringex'

module Questionable
  class Engine < ::Rails::Engine
    isolate_namespace Questionable

    initializer :questionable do
      if defined?(ActiveAdmin)
        dir = File.dirname(__FILE__) + '/admin'
        # Prepend the load paths, which should allow this to be overridden by an app.
        # If we wanted to prevent an override, we could append dir to load_paths instead.
        ActiveAdmin.application.load_paths.unshift dir
        #ActiveAdmin.application.load_paths += dir
      end
    end

    config.generators do |g|
      g.test_framework :rspec, :view_specs => false, :fixture => false
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
      g.assets false
      g.helper false
    end
  end
end
