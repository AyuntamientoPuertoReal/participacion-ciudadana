Rails.application.routes.draw do
  devise_for :staffs
  get 'demo/index', to: 'demo#index', as: 'demo'
  root to: 'demo#index'

  get 'api/v1/incidences_historical/:id', to: 'api#show_incidences_historical'
  mount Apicasso::Engine, at: "/api/v1"

end
