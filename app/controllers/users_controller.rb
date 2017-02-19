class UsersController < ApplicationController

  before_action :authenticate_user!
  def games
    @user = current_user
    @games = @user.games.paginate(page: params[:page], per_page: 20)
  def requested_games
    response = params[:pendingImage]
    if response
      response.each do |game|
        game = json(game)
        id = game['id']
        @game = Game.find(id)
        if params[:commit] == "Decline"
          @game.mooch_user = nil
        else
          @game.mooched = true
        end
        @game.save
      end
      redirect_to request.env["HTTP_REFERER"]
    else
      flash[:error] = "Please select a game"
      redirect_to request.env["HTTP_REFERER"]
    end
  end

  def delete_games
    response = params[:selectImage]
    if response
      response.each do |game|
        game = json(game)
        id = game['id']
        @game = Game.find(id)
        @game.destroy
      end
      redirect_to request.env["HTTP_REFERER"]
    else
      flash[:error] = "Please select a game"
      redirect_to request.env["HTTP_REFERER"]
    end
  end

end
