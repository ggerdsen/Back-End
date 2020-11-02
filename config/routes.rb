# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :students, :teachers
      get '/students/find/:uid', to: 'students#find'
      get '/teachers/find/:uid', to: 'teachers#find'
    end
  end
end
