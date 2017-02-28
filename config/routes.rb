Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks", :registrations => "registrations" }
  get 'welcome/index'
  get 'igdb/search'
  get 'igdb/games'
  get 'users/mooched_games'
  get 'users/moochedby_games'
  get 'users/requested_games'
  get 'users/pending_games'
  post 'users/requested_games'
  get 'users/delete_games'
  get 'games/mooch'
  get 'games/unmooch'
  get 'games/cancelmooch'
  get 'games/autocomplete'

  root 'welcome#index'

  resources :games
  resources :users do |user|
      resources :games
  end

end
