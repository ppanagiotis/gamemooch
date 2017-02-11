class IgdbController < ApplicationController

  before_action :authenticate_user!
  def games
    game = IgdbHelper::Game.new(params[:search],  ["name", "genres", "cover"], "games" , 20)
    response = game.search
    @games = response
  end
end
