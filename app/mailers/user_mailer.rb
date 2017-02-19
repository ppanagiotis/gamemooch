class UserMailer < ApplicationMailer
  def send_request(user, title)
    @user = user
		@title = title
    mail( :to => @user.email,
    :subject => 'New request for one of your games' )
  end

  def send_approval(user, title)
    @user = user
		@title = title
    mail( :to => @user.email,
    :subject => 'You mooch a game!' )
  end
end
