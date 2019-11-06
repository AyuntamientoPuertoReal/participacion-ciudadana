Rails.application.routes.draw do
  devise_for :staffs
  get 'demo/index'
  root to: 'demo#index'

  mount Apicasso::Engine, at: "/api/v1"



end
