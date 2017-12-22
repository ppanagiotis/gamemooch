module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def get_platforms
    @platforms ||= Console.pluck(:name)
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def bootstrap_class_for(flash_type)
    case flash_type
    when "success"
      "alert-success"   # Green
    when "error"
      "alert-danger"    # Red
    when "alert"
      "alert-warning"   # Yellow
    when "notice"
      "alert-info"      # Blue
    else
      flash_type.to_s
    end
  end
end

def games_grid(games)
  @games.map  {
    |game| [ {
      data: { 'img-src': game.url }
    },
    if game.console then "<b>#{game.title}</b> <hr> Owner: <b> #{game.user.username} </b> <hr> Plarform: <b>#{game.console.name}"
    elsif game.user.username? then "<b>#{game.title}</b> <hr> Owner: <b> #{game.user.username} </b>"
    else  "<b>#{game.title}</b> <hr> Owner: <b> #{game.user.email} </b>"
    end ,
    [ 'id' => game.id, 'name' =>  game.title, 'cover' => game.url, 'owner' => game.user.email ] ]
  }
end
