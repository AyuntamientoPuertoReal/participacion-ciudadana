Rails.application.routes.draw do
  devise_for :staffs

  mount Apicasso::Engine, at: "/api/v1"

  # Controlador de demostración que sólo está en local. Se eliminará una vez que haya algún controlador real.
  # get 'demo/index'
  # root to: 'demo#index'
end
