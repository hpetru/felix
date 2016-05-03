Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      get 'flexy_table', to: 'flexy_table#index'
    end
  end

  root 'dashboard#index'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :subjects
  resources :student_groups
end
