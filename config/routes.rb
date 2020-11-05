# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :teachers do
        get '/courses/find', to: 'search#show'
        post '/courses/wars', :action => 'create_war'
        resources :courses do
        end
      end

      namespace :students do
        get '/courses/all-points', to: 'courses#all_points'
        get '/courses/points', to: 'courses#points'
        resources :courses
      end
      resources :students, :teachers
      get '/students/find/:uid', to: 'students#find'
      get '/teachers/find/:uid', to: 'teachers#find'
    end
  end
end
