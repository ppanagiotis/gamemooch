class GamesController < ApplicationController

  before_action :authenticate_user!
  def index
    if params[:query].present?
      @games = Game.search params[:query], where: { mooch_user_id: nil }
    else
      if params[:user_id]
        @user = User.find(params[:user_id])
        if @user == current_user
          @games = @user.games.paginate(page: params[:page], per_page: 15)
          render "users/games"
        else
          @games = @user.games.where(:mooch_user_id => nil).order("created_at").reverse_order.paginate(page: params[:page], per_page: 15)
        end
      else
        @games = Game.where(:mooch_user_id => nil).order("created_at").reverse_order.paginate(page: params[:page], per_page: 15)
      end
    end
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
      redirect_to request.env["HTTP_REFERER"]
    else
      flash[:error] = "Please select a game"
      redirect_to request.env["HTTP_REFERER"]
    end
  end

  def mooch
    response = params[:selectImage]
    @games = []
    if response
      response.each do |mooch_game|
        game = json(mooch_game)
        id = game['id']
        @game = Game.find(id)
        if current_user.games.where(:id => id).present?
          flash[:error] = "#{game['name']} is yours"
        else
          @game.mooch_user = current_user
          UserMailer.send_request(@game.user, @game.title).deliver
          @game.save
          @games.append(@game.title)
        end
      end
      flash[:success] = "#{@games.to_sentence} Mooched"
      redirect_to games_url
    else
      flash[:error] = "Please select a game"
      redirect_to request.env["HTTP_REFERER"]
    end
  end

  def unmooch
    response = params[:selectImage]
    @games = []
    if response
      response.each do |mooch_game|
        game = json(mooch_game)
        id = game['id']
        @game = Game.find(id)
        @game.mooch_user = nil
        @game.mooched = false
        @game.save
        @games.append(@game.title)
      end
      flash[:success] = "#{@games.to_sentence} Unmooched"
      redirect_to request.env["HTTP_REFERER"]
    else
      flash[:error] = "Please select a game"
      redirect_to request.env["HTTP_REFERER"]
    end
  end

  def cancelmooch
    response = params[:selectImage]
    @games = []
    if response
      response.each do |mooch_game|
        game = json(mooch_game)
        id = game['id']
        @game = Game.find(id)
        @game.mooch_user = nil
        @game.mooched = false
        @game.save
        @games.append(@game.title)
      end
      flash[:error] = "#{@games.to_sentence} canceled"
      redirect_to request.env["HTTP_REFERER"]
    else
      flash[:error] = "Please select a game"
      redirect_to request.env["HTTP_REFERER"]
    end
  end

  def autocomplete
    render json: Game.search(params[:query], {
      fields: ["title"],
      match: :word_start,
      load: false,
      limit: 10,
      misspellings: false,
    }).map(&:title)
  end

private
  def game_params
    params.permit(:title, :id, :igdb_id, :url)
  end
end
