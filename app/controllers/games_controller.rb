class GamesController < ApplicationController

  before_action :authenticate_user!
  def index
    @games = Game.paginate(page: params[:page], per_page: 20)
  end

  def new
    response = params[:selectImage]
    response.each do |igdb_game|
      @game = Game.new(game_params)
      @game.user = current_user
      game = Hash[*eval(igdb_game)]
      @game.title= game['name']
      @game.url = game['cover']
      @game.igdb_id = game['id']
      @game.save
    end
      if @game.save
        flash[:success] = "Saved successfully"
        redirect_to games_path
      else
        flash[:error] = "Games not saved"
        redirect_to request.env["HTTP_REFERER"]
      end
  end

private
  def game_params
    params.permit(:title, :id, :igdb_id, :url)
  end
end
