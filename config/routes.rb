# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api do
    namespace :v1 do
      resource :quizzes, only: [] do
        post 'gpt', to: 'quizzes#create_gpt', on: :collection
        post 'gemini', to: 'quizzes#create_gemini', on: :collection
      end

      namespace :admin do
        resources :ai_queries, except: %i[create edit]
        resources :ai_query_types, except: %i[show edit]
      end
    end
  end

  get '/health_check', to: 'health_checks#check'
end
