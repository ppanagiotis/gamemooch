class CallbacksController < Devise::OmniauthCallbacksController
  def all(provider)
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:success, :success, :kind => provider) if is_navigational_format?
    else
      redirect_to new_user_session_url
      set_flash_message(:error, :failure, :kind => provider , :reason => "You have signed up using different provider") if is_navigational_format?
    end
  end

  def facebook
    all("Facebook")
  end

  def github
    all("Github")
  end

  def google_oauth2
    all("Google")
  end

end
