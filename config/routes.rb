Rails.application.routes.draw do
  devise_for :staffs

  # Descomentar el if y el end cada vez que quieran ocultarse las cosas en construcción en producción
  # if Rails.env.development? | Rails.env.test?
    # Controlador de demostración. Se eliminará una vez que haya algún controlador real.
    get 'demo/index', to: 'demo#index', as: 'demo'
    root to: 'demo#index'

    resources :staffs, except: [:show]
  # end

  get 'api/v1/incidences_historical/:id', to: 'api#show_incidences_historical'
  mount Apicasso::Engine, at: "/api/v1"
end
