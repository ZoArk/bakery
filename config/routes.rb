Rails.application.routes.draw do
  devise_for :users

  # Admin routes
  namespace :admin do
    resources :products
    resources :categories
    get 'dashboard', to: 'dashboard#index'
  end

  # Cart routes
  resources :cart, only: [:show] do
    collection do
      post :add_to_cart
      post :create
    end
    member do
      patch :update_quantity
      delete :remove_item
    end
  end

  # Checkout routes
  resources :checkout, only: [:buy] do
  collection do
    get :buy
    post 'checkout/payment', to: 'checkout#payment', as: :payment_checkout
    get :thankyou
  end

end


  # Order routes
  resources :orders, only: [:new, :create, :show]

  # Customer-facing routes
  resources :products, only: [:index, :show]

  # Static pages
  get 'about', to: 'pages#about'

  # Set the root path
  root "products#index"


  # Other routes (health checks, PWA files, etc.)
  get "up", to: "rails/health#show", as: :rails_health_check
  get "service-worker", to: "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest", to: "rails/pwa#manifest", as: :pwa_manifest
end

