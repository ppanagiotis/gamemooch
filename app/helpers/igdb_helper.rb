module IgdbHelper
  class Game
    include HTTParty
    debug_output $stdout
    base_uri "https://igdbcom-internet-game-database-v1.p.mashape.com"

    def initialize(search_term, fields= [], endpoint='games', limit=10)
      @endpoint = "/#{endpoint}/"
      fields = fields.join(',')
      @options = { query: { fields: fields, limit: limit, search: search_term } ,
                   headers: {'X-Mashape-Key' => Rails.application.config_for(:secrets)['mashape_key'] }
      }
    end

    def search
      @response = self.class.get( @endpoint, @options)
      @result = JSON.parse(@response.body)
      @result.each do |entry|
        if !entry['cover'].nil?
          entry['cover']['url'].gsub! 't_thumb', 't_cover_med'
        else entry['cover'] = {'url' => "//images.igdb.com/igdb/image/upload/t_cover_med/nocover_qhhlj6.jpg" }
        end
      end
    end
  end
end
