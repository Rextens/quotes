Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq/cron/web'

  get '/cloud', to: "cloud#cloud"
  root "quotes#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/logo', to: "cloud#logo"

  get "/vote", to: "voting#vote"
  resources :quotes

  resources :voting do
    collection do
      get 'createp'
    end
  end

  match '/voting/voteForQuote', via: [:post]

  resources :vote
end
