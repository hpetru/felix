Rails.application.routes.draw do
  root 'dashboard#index'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
end
