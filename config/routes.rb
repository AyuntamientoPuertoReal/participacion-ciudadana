Rails.application.routes.draw do
  devise_for :staffs

  # Controlador de demostración. Se eliminará una vez que haya algún controlador real.
  get 'demo/index', to: 'demo#index', as: 'demo'
  root to: 'demo#index'

  get 'api/v1/incidences_historical/:id', to: 'api#show_incidences_historical'
  post 'api/v1/incidences/send', to: 'api#post_incidences'
  mount Apicasso::Engine, at: "/api/v1"
end
