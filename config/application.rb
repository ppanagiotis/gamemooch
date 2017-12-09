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
    config.default_image = "//images.igdb.com/igdb/image/upload/t_cover_med/nocover_qhhlj6.jpg"
    config.platforms = {
      "xbox" => 11,
      "xbox360" => 12,
      "xboxone" => 49,
      "pc" => 6,
      "ps" => 7,
      "ps2" => 8,
      "ps3" => 9,
      "ps4" => 48,
      "psp" => 38,
      "psvita" => 46,
      "nes" => 18,
      "snes" => 19,
      "n64" => 4,
      "gamecube" => 21,
      "wii" => 5,
      "wiiu" => 41,
      "ds" => 20,
      "3ds" => 37,
      "dreamcast" => 23
    }
  end
end