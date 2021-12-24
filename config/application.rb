require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
# require "sprockets/railtie"
require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FonkieTest
  class Application < Rails::Application
    config.before_configuration do
      redis = `ps -ax | grep [6]379 && echo $?`
      unless redis.include? 'redis'
        begin
          system('redis-server --port 6379 &')
        rescue StandardError
          true
        end
        begin
          system('rm /app/tmp/pids/server.pid')
        rescue StandardError
          true
        end
      end
      sidekiq = `ps -ax | grep [s]idekiq && echo $?`
      unless sidekiq.include? 'sidekiq'
        begin
          Sidekiq.redis(&:flushdb)
        rescue StandardError
          true
        end
        begin
          system('bundle exec sidekiq &')
        rescue StandardError
          true
        end
      end
    end
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "America/Bogota"
    # config.eager_load_paths << Rails.root.join("extras")
    config.autoload_paths += %W[#{config.root}/app/workers]
    config.eager_load_paths += %W[#{config.root}/lib/services]
    config.autoload_paths << "#{Rails.root}/lib/services"
    config.autoload_paths << "#{Rails.root}/spec"
    config.autoloader = :classic
    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
    if defined?(Rails::Server)
      config.after_initialize do
        # Do stuff here
        ReqresImporter.new.create_users unless User.count.positive?
      end
    end
  end
end
