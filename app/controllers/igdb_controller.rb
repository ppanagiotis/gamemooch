class IgdbController < ApplicationController

  before_action :authenticate_user!
  def games
    platforms = Rails.configuration.platforms
    platform = Game.consoles[params[:platform]]
    game = IgdbHelper::Game.new(params[:search],  ["name", "genres", "cover", "platforms"], "games" , 49)
    response = game.search(platform=platform)
    @platforms = platforms.keys
    @games = response
  end

  def search
    platforms = Rails.configuration.platforms
    @platforms = platforms.keys
  end
end
