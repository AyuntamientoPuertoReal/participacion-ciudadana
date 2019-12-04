Rails.application.routes.draw do
  devise_for :staffs

  # Descomentar el if y el end cada vez que quieran ocultarse las cosas en construcción en producción
  # if Rails.env.development? | Rails.env.test?
    # Controlador de demostración. Se eliminará una vez que haya algún controlador real.
    get 'demo/index', to: 'demo#index', as: 'demo'
    root to: 'demo#index'

    authenticate :staff do
      resources :staffs, except: [:show]
      resources :processing_units, except: [:show]
      resources :incidence_trackings, except: [:show]
      resources :incidence_types, except: [:show]
      get 'incrementorder/:id', to: 'incidence_types#increment_order', as: 'increment_order'
      get 'decrementorder/:id', to: 'incidence_types#decrement_order', as: 'decrement_order'
      get 'incidences/index'
      get 'incidences/show'
    end
  # end

  get 'api/v1/incidences_historical/:id', to: 'api#show_incidences_historical'
  post 'api/v1/incidences/send', to: 'api#post_incidences'
  mount Apicasso::Engine, at: "/api/v1"
end
