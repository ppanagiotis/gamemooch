class UsersController < ApplicationController

  before_action :authenticate_user!
  def games
    @user = current_user
    @games = @user.games.paginate(page: params[:page], per_page: 20)
  end
end
