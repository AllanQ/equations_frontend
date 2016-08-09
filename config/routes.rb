Rails.application.routes.draw do
  get 'equations/index'
  get 'equations/auth'
  root 'equations#index'
end
