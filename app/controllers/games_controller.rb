class GamesController < ApplicationController

  def index
    @games = Game.all
  end

  def new
    response = params[:selectImage]
    response.each do |igdb_game|
      @game = Game.new(game_params)
      game = Hash[*eval(igdb_game)]
      @game.title= game['name']
      @game.url = game['cover']
      @game.igdb_id = game['id']
      @game.save
    end
    redirect_to games_path
  end

private
  def game_params
    params.permit(:title, :id, :igdb_id, :url)
  end
end
