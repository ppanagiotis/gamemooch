require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Gamemooch
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.igdb_base_uri = "https://api-2445582011268.apicast.io"
    config.default_image = ActionController::Base.helpers.asset_path('no-image')
    config.platforms = {
#      "xbox" => 11,
      "Xbox 360" => 12,
      "xbox One" => 49,
      "PC" => 6,
#      "ps" => 7,
#      "ps2" => 8,
      "PlayStation 3" => 9,
      "PlayStation 4" => 48,
      "PSP" => 38,
      "PS VITA" => 46,
#      "nes" => 18,
#      "snes" => 19,
#      "n64" => 4,
#      "gamecube" => 21,
      "Wii" => 5,
      "WiiU" => 41,
      "DS" => 20,
      "3DS" => 37,
      "Switch" => 130,
#      "dreamcast" => 23
    }
  end
end
