Rails.application.routes.draw do
  # Devise routes for admins
  devise_for :admins, controllers: {
    sessions: 'admin/sessions',
    registrations: 'admin/registrations'
  }, path: 'admins', path_names: {
    sign_in: 'sign_in',
    sign_out: 'sign_out',
    sign_up: 'sign_up'
  }

  # Devise routes for users
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }, path: 'users', path_names: {
    sign_in: 'sign_in',
    sign_out: 'sign_out',
    sign_up: 'sign_up'
  }

  # Admin namespace routes
  namespace :admin do
    root 'dashboard#index' # Admin dashboard root route
    resources :users, only: [:index, :show] do
      member do
        get 'add_money'    # Custom route for adding money
        post 'update_balance' # To handle the actual update
      end
    end
  end

  namespace :api do
    namespace :v1 do
      # Custom routes for sessions and users
      get 'user_data', to: 'users#user_data'
      post 'sessions', to: 'sessions#create'
      delete 'sessions', to: 'sessions#destroy'
      resources :users, only: [:user_data, :create, :update, :destroy]
      post 'sign_up', to: 'users#sign_up'

      # Devise routes for API
      devise_scope :user do
        post 'sign_in', to: 'sessions#create'
        delete 'sign_out', to: 'sessions#destroy'
        post 'sign_up', to: 'registrations#create'
      end
    end
  end


  # Define other routes
  get '/member-data', to: 'members#show'
  root 'home#index' # Root route for the application
  get '/dashboard', to: 'dashboard#index', as: 'user_dashboard'
end
