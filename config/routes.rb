Rails.application.routes.draw do
  root 'dashboard#index'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :subjects
  resources :student_groups
end
