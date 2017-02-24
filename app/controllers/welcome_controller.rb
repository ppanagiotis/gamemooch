class WelcomeController < ApplicationController
  def index
    @games = Game.all.limit(12).order("created_at").reverse_order
  end
end
