Rails.application.routes.draw do
  resources :prescriptions, only: [:index, :create]
  # Define routes for the 'users' resource with only 'index' and 'create' actions
  resources :users,  only: [:index, :create]
  
  
  # Define routes for the 'appointments' resource with 'index' and 'create' actions
  resources :appointments, only: [:index, :create] do
    # Define custom collection route to get available timeslots
    collection do
      get 'available_timeslots'
    end
    # Define custom member routes to mark appointments as fulfilled or missed
    member do
      patch 'mark_as_fulfilled'
      patch 'mark_as_missed'
    end
  end

  # Define routes for the 'admin' resource with only 'index' action
  resources :admin, only: [:index] do
    # Define custom member routes to mark admin actions as fulfilled or missed
    patch 'mark_as_fulfilled/:id', to: 'admin#mark_as_fulfilled', on: :member
    patch 'mark_as_missed/:id', to: 'admin#mark_as_missed', on: :member
  end

  # Define a custom route for user signup
  post "/signup", to: "users#create"
  
  # Define a custom route to retrieve user information
  get "/me", to: "users#show"

  # Define a custom route for user login
  post "/login", to: "sessions#create"
  
  # Define a custom route for user logout
  delete "/logout", to: "sessions#destroy"
end
