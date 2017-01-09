require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Mysite
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.assets.precompile += %w(*.js)
    config.active_job.queue_adapter = :sidekiq
    config.assets.initialize_on_precompile = false
    config.generators do |g|
    	g.test_framework :rspec 
    	# g.factory_girl false 
    end
  end
end
