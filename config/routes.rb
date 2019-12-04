Rails.application.routes.draw do
  devise_for :staffs

  # Controlador de demostración. Se eliminará una vez que haya algún controlador real.
  get 'demo/index', to: 'demo#index', as: 'demo'
  root to: 'demo#index'

  authenticate :staff do
    resources :staffs, except: [:show]
    resources :processing_units, except: [:show]
    resources :incidence_trackings, except: [:show]
    resources :incidence_types, except: [:show]
    get 'incidences/index'
    get 'incidences/show'
  end

  get 'api/v1/incidences_historical/:id', to: 'api#show_incidences_historical'
  post 'api/v1/incidences/send', to: 'api#post_incidences'
  mount Apicasso::Engine, at: "/api/v1"

  if Rails.env.development? | Rails.env.test?
    # Meter aquí las rutas de los recursos que estén en desarrollo y que no se quiere que se vean en producción.
  end
end
