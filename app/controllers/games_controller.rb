class GamesController < ApplicationController

  before_action :authenticate_user!
  def index
    @games = Game.where(:mooch_user_id => nil).order("created_at").reverse_order.paginate(page: params[:page], per_page: 20)
  end

  def new
    response = params[:selectImage]
    if response
      response.each do |igdb_game|
        game = json(igdb_game)
        @game = Game.new(game_params)
        @game.user = current_user
        @game.title= game['name']
        @game.url = game['cover']
        if current_user.games.where(:igdb_id => game['id']).present?
          flash[:error] = "You already have #{game['name']}"
        else
          @game.igdb_id = game['id']
          if @game.save
            flash[:success] = "Saved successfully"
          else
            flash[:error] = "Games not saved"
            redirect_to request.env["HTTP_REFERER"]
          end
        end
      end
      redirect_to games_path
    else
      flash[:error] = "Please select a game"
      redirect_to request.env["HTTP_REFERER"]
    end
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
