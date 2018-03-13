require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WikiIt
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.autoload_paths << File.join(config.root, "lib")

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.generators do |g|
      g.view_specs false
      g.helper_specs false
      g.controller_specs false
    end


  if Rails.env.development? || Rails.env.production?
    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = {
      address:        'smtp.sendgrid.net',
      port:           '2525',
      authentication: :plain,
      user_name:      ENV['SENDGRID_USERNAME'],
      password:       ENV['SENDGRID_PASSWORD'],
      domain:         'heroku.com',
      enable_starttls_auto: true
    }
  end
end
