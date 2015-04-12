Rails.application.routes.draw do
  resources :parses, only: [:create]
  resources :pastes, only: [:show, :create]
  get '/pastes', to: redirect('/')
end
