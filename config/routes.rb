Rails.application.routes.draw do
  root to: 'home_pages#show'

  resources :parses, only: [:create]
  resources :pastes, only: [:show, :create]
  get '/pastes', to: redirect('/')
end
