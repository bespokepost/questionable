Rails.application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users

  mount Questionable::Engine, at: 'questionable'

  root to: 'users#index'
end
