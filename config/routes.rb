# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :teachers do
        get '/courses/find', to: 'search#show'
        resources :courses do
        end
      end

      namespace :students do
        resources :courses
      end
      resources :students, :teachers
      scope controller: :students do
        get '/find/:uid', to: 'students#find'
      end
      get '/pom/single_trivia_question', to: 'poms#single_trivia_question'
    end
  end

end
