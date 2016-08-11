Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  get 'equations/index'
  get 'equations/auth'
  root 'equations#index'
end
