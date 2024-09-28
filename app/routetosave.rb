# Rails.application.routes.draw do
#   # API routes
#   namespace :api do
#     resources :users, only: [:index, :show]
#   end

#   # Devise routes for users
#   devise_for :users,
#              controllers: {
#                sessions: 'users/sessions',
#                registrations: 'users/registrations'
#              }

#   # Root path
#   root 'home#index'

#   # User Dashboard
#   get '/dashboard', to: 'dashboard#index', as: 'user_dashboard'

#   # Transactions route
#   post '/transactions', to: 'transactions#create'

#   # Admin routes
#   namespace :admin do
#     # Registration and session routes
#     get 'signup', to: 'registrations#new', as: 'signup'
#     post 'signup', to: 'registrations#create'
#     get 'login', to: 'sessions#new', as: 'login'
#     post 'login', to: 'sessions#create'
#     delete 'logout', to: 'sessions#destroy', as: 'logout'

#     # Dashboard route
#     get 'dashboard', to: 'dashboard#index', as: 'dashboard'

#     # User management routes
#     resources :users, only: [:index, :show, :update] do
#       member do
#         get 'edit'
#         get 'add_money'
#         patch 'add_balance'
#         get 'reset_password'
#         patch 'update_password'
#       end
#     end
#   end
# end

Rails.application.routes.draw do
  # API routes
  namespace :api do
    resources :users, only: [:index, :show]
  end

  # Devise routes for users
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }

  # Devise routes for admins
  devise_for :admins,
             controllers: {
               sessions: 'admins/sessions',
               registrations: 'admins/registrations'
             },
             path: 'admin',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               sign_up: 'signup'
             }

  # Root path
  root 'home#index'

  # User Dashboard
  get '/dashboard', to: 'dashboard#index', as: 'user_dashboard'

  # Payments route
  post '/payments', to: 'payments#create'

  # Admin routes
  namespace :admins do
    get 'dashboard', to: 'dashboard#index', as: 'dashboard'
    get 'users/:id/add_money', to: 'dashboard#add_money', as: 'add_money'
    patch 'users/:id/update_balance', to: 'dashboard#update_balance', as: 'update_balance'
  end
end
