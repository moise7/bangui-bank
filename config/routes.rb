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
    resources :users, only: [:index, :edit, :update] do
      member do
        get 'add_money'    # Custom route for adding money
        post 'update_balance' # To handle the actual update
      end
    end
  end

  # Define other routes
  get '/member-data', to: 'members#show'
  root 'home#index' # Root route for the application
  get '/dashboard', to: 'dashboard#index', as: 'user_dashboard'
end
