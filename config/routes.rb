Rails.application.routes.draw do
  root to: "videos#index"

  resources :videos, only: %w(show index)
end
