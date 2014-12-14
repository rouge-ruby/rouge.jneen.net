Rails.application.routes.draw do
  resources :parses, only: [:create]
end
