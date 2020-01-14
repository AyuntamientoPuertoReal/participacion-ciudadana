Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :staffs

  # Controlador de demostración. Se eliminará una vez que haya algún controlador real.
  get 'demo/index', to: 'demo#index', as: 'demo'
  root to: 'demo#index'

  authenticate :staff do
    resources :staffs, except: [:show]
    resources :news
    resources :processing_units, except: [:show]
    get 'assign_incidence_type/:id', to:'processing_units#assign_incidence_types', as: 'assign_it'
    get 'unassign_incidence_type/:id', to:'processing_units#unassign_incidence_types', as: 'unassign_it'
    resources :incidence_trackings, except: [:show]
    resources :incidence_types, except: [:show]
    get 'incrementorder/:id', to: 'incidence_types#increment_order', as: 'increment_order'
    get 'decrementorder/:id', to: 'incidence_types#decrement_order', as: 'decrement_order'
    get 'incidences/index'
    get 'incidences/show'
    resources :incidences, only: [:index, :show]
    resources :incidence, except: [:index, :show] do
      resources :incidence_trackings
    end
  end

  get 'api/v1/incidences_historical/:id', to: 'api#show_incidences_historical'
  post 'api/v1/incidences/send', to: 'api#post_incidences'
  mount Apicasso::Engine, at: "/api/v1"
end
