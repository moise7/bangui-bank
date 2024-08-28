Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }

  get '/member-data', to: 'members#show'

  # Correctly define the root path
  root 'home#index' # Assuming you have a HomeController with an index action
    # Define a dashboard route
    get '/dashboard', to: 'dashboard#index', as: 'user_dashboard'
end
