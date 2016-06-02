Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      get 'typeahead', to: 'typeahead#index'
      get 'flexy_table', to: 'flexy_table#index'

      namespace 'flexy_table' do
        post 'cells', to: 'cells#save'
      end
    end
  end

  root to: redirect('admin')

  ActiveAdmin.routes(self)
  devise_for(
    :users,
    {
      class_name: 'User'
    }.merge(ActiveAdmin::Devise.config)
  )
end
