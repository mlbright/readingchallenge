Rails.application.routes.draw do
  get "welcome/index"
  # Authentication routes
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  get "setup_password", to: "sessions#setup_password"
  post "setup_password", to: "sessions#complete_setup"

  # Registration routes
  get "admin_signup", to: "registrations#admin_signup"
  post "admin_signup", to: "registrations#create_admin", as: "create_admin"
  get "signup", to: "registrations#signup"
  post "signup", to: "registrations#create", as: "create_signup"

  # Admin routes
  namespace :admin do
    resources :users, only: [ :index, :new, :create, :destroy ]
  end

  # Resources
  resources :users, only: [ :index, :show ]

  resources :challenges do
    member do
      post "join"
      delete "leave"
      get "leaderboard"
      get "invite"
      post "add_users"
      patch "update_goal"
    end

    resources :books do
      resources :votes, only: [ :create, :destroy ]
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "welcome#index"
end
