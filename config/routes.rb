Rails.application.routes.draw do
  root 'welcome#home'

  resources :users
  resources :attractions

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  post '/signout' => 'sessions#destroy'

  post '/attraction/:id' => 'attractions#ride'
end
