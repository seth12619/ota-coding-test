Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root to: redirect { |params, req|
    cart = Cart.first || Cart.create!
    "/carts/#{cart.id}/add_item"
  }
  namespace :api do
    resources :carts, only: [:show] do
      post :add_item, on: :member
    end
  end
  resources :carts, only: [:show] do
    member do
      match :add_item, via: [:get, :post]
    end
  end
end
