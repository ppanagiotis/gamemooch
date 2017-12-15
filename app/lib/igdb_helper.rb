module IgdbHelper
  class Game
    include HTTParty
    base_uri  Rails.configuration.igdb_base_uri

    def initialize(search_term, fields= [], endpoint='games', limit=49)
      @endpoint = "/#{endpoint}/"
      fields = fields.join(',')
      @options = { query: { fields: fields, limit: limit, search: search_term } ,
                   headers: {'user-key' => Rails.application.config_for(:secrets)['mashape_key'] }
      }
    end

    def search(platform)
      games=Array.new
      @response = self.class.get( @endpoint, @options)
      @result = JSON.parse(@response.body)
      @result.each do |entry|
        if !entry['platforms'].nil? && entry['platforms'].include?(platform)
          if !entry['cover'].nil?
            entry['cover']['url'].gsub! 't_thumb', 't_cover_med'
          else
            entry['cover'] = {'url' => Rails.configuration.default_image }
          end
        games << entry
        end
      end
      return games
    end
  end
end
