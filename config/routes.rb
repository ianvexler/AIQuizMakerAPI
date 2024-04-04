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
        collection do
          post 'gpt', to: 'quizzes#create_gpt'
          post 'gemini', to: 'quizzes#create_gemini'
        end
      end

      namespace :admin do
        resources :query_types, except: %i[show edit] do
          resources :queries, except: %i[edit], controller: 'query_types/queries' do
            get 'test', to: 'queries#test', on: :collection
          end
        end
      end
    end
  end

  get '/health_check', to: 'health_checks#check'
end
