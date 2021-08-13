Rails.application.routes.draw do
  resources :votes, only: :create
end
