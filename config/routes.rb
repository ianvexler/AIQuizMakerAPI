# frozen_string_literal: true

Rails.application.routes.draw do
  # Devise authentication.
  devise_for :users, path: 'user'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api do
    namespace :v1 do
      resource :auth, controller: :sessions, only: %i[create destroy] do
        post :signup
        patch :refresh
      end

      resources :courses, only: %i[index show] do
        resources :topics, only: %i[index]
      end
      resources :quizzes, only: %i[create show] do
        collection do
          post :create_from_file
        end
      end
    end
  end

  get '/health_check', to: 'health_checks#check'
end
