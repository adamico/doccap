require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Doccap
  class Application < Rails::Application
    config.assets.enabled = true
    config.assets.precompile += Ckeditor.assets
    config.assets.precompile += %w(ckeditor/*)
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    #
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Paris'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.default_locale = :fr
    config.i18n.enforce_available_locales = false

    config.generators do |g|
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.view_specs         false
      g.helper_specs       false
      g.controller_specs   false
      g.routing_specs      false
      g.stylesheets        false
    end
  end
end
