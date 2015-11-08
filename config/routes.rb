Rails.application.routes.draw do
  root 'welcome#index'
  
  get 'employee', to: 'welcome#employee'
  resources :employees, only: [:show]
end
