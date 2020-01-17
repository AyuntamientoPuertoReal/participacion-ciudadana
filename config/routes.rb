Rails.application.routes.draw do
  devise_for :staffs

  # Controlador de demostración. Se eliminará una vez que haya algún controlador real.
  get 'demo/index', to: 'demo#index', as: 'demo'
  root to: 'demo#index'

  authenticate :staff do
    resources :staffs, except: [:show]
    resources :news
    resources :processing_units, except: [:show]
    resources :incidence_trackings, except: [:show]
    resources :incidence_types, except: [:show]
    resources :interest_points, except: [:show]
    resources :incidences, only: [:index, :show]
    resources :incidence, except: [:index, :show] do
      resources :incidence_trackings
    end
    
    get 'assign_incidence_type/:id', to:'processing_units#assign_incidence_types', as: 'assign_it'
    get 'unassign_incidence_type/:id', to:'processing_units#unassign_incidence_types', as: 'unassign_it'

    get 'assign_pu_staff/:id', to:'processing_units#assign_pu_staff', as: 'assign_pu_staff'
    get 'unassign_pu_staff/:id', to:'processing_units#unassign_pu_staff', as: 'unassign_pu_staff'

    get 'assign_staff/:id', to:'staffs#assign_staff', as: 'assign_staff'
    get 'unassign_staff/:id', to:'staffs#unassign_staff', as: 'unassign_staff'

    get 'assign_pu_it/:id', to:'incidence_types#assign_pu_it', as: 'assign_pu_it'
    get 'unassign_pu_it/:id', to:'incidence_types#unassign_pu_it', as: 'unassign_pu_it'

    get 'incrementorder/:id', to: 'incidence_types#increment_order', as: 'increment_order'
    get 'decrementorder/:id', to: 'incidence_types#decrement_order', as: 'decrement_order'
  end

  get 'api/v1/incidences_historical/:id', to: 'api#show_incidences_historical'
  post 'api/v1/incidences/send', to: 'api#post_incidences'
  mount Apicasso::Engine, at: "/api/v1"
end
