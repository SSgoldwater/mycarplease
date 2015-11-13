Rails.application.routes.draw do
  root 'welcome#index'
  
  get 'employee', to: 'welcome#employee'

  resources :customers, only: [:new, :create, :update]
  resources :employees, only: [:show]

  namespace :api do
    namespace :v1 do
      post 'clockin', to: 'employees#clockin', defaults: { format: 'json' } 
      resources :vehicles, except: [:new, :edit], defaults: { format: 'json' }
    end
  end
end
