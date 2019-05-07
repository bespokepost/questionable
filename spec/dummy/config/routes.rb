Rails.application.routes.draw do
  devise_for :users

  mount Questionable::Engine, at: 'questionable'

  root to: 'users#index'
end
