class IgdbController < ApplicationController

  def games
    game = IgdbHelper::Game.new(params[:search],  ["name", "genres", "cover"], "games" , 20)
    response = game.search
    @games = response
  end

private
  def game_params
    params.require(:game).permit(:title, :description)
  end
end
