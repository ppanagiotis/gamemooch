class UsersController < ApplicationController

  before_action :authenticate_user!
  def games
    @user = current_user
    @games = @user.games.where(:mooch_user_id => nil).paginate(page: params[:page], per_page: 15)
  end

  def mooched_games
    @user = current_user
    @games = @user.mooched_games.where(:mooched => true).paginate(page: params[:page], per_page: 15)
  end

  def pending_games
    @user = current_user
    @pending_games = @user.mooched_games.where(:mooched => false).paginate(page: params[:page], per_page: 15)
  end

  def moochedby_games
    @user = current_user
    @mooched_games = @user.games.where.not(:mooch_user_id => nil).where(:mooched => true).order("created_at").reverse_order.paginate(page: params[:page], per_page: 15)
  end

  def requested_games
    if request.post?
      response = params[:selectImage]
      if response
        response.each do |game|
          game = json(game)
          id = game['id']
          @game = Game.find(id)
          if params[:commit] == "Decline"
            @game.mooch_user = nil
          else
            @game.mooched = true
            UserMailer.send_approval(@game.mooch_user, @game.title).deliver
          end
          @game.save
        end
        redirect_to request.env["HTTP_REFERER"]
      else
        flash[:error] = "Please select a game"
        redirect_to request.env["HTTP_REFERER"]
      end
    else
      @user = current_user
      @requested_games = @user.games.where.not(:mooch_user_id => nil).where(:mooched => false).order("created_at").reverse_order.paginate(page: params[:page], per_page: 15)
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
