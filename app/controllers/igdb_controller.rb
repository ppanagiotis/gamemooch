class IgdbController < ApplicationController

  before_action :authenticate_user!
  def games
    platforms = Rails.configuration.platforms
    game = IgdbHelper::Game.new(params[:search],  ["name", "genres", "cover", "platforms"], "games" , 49)
    #search for ps4 games for now ;-)
    response = game.search(platform=platforms["ps4"])
    @games = response
  end
end
