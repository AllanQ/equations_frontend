Rails.application.routes.draw do
  resources :equations, only: [:index, :create]
  root 'equations#index'
end
